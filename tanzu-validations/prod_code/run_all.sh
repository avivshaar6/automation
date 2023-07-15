#!/bin/bash

# This part is for deploying all the five test VMs
vm_ip_tkgm_avi=$(cat vars.yml | yq .tkgm_vms_01[0].ip)
vm_ip_tkgm_mgmt=$(cat vars.yml | yq .tkgm_vms_01[1].ip)
vm_ip_workload=$(cat vars.yml | yq .tkgm_vms_01[2].ip)
vm_ip_tkgm_vip=$(cat vars.yml | yq .tkgm_vms_02[0].ip)
vm_ip_tkgm_cp_vip=$(cat vars.yml | yq .tkgm_vms_02[1].ip)

echo "create /etc/ansible/hosts file"
sudo mkdir /etc/ansible
sudo touch /etc/ansible/hosts
echo '[all]' | sudo tee -a /etc/ansible/hosts > /dev/null

echo "Now we add all VMs in the /etc/ansible/hosts file!!!"
cat vars.yml | yq .tkgm_vms_01[].ip | sudo tee -a /etc/ansible/hosts > /dev/null
cat vars.yml | yq .tkgm_vms_02[].ip | sudo tee -a /etc/ansible/hosts > /dev/null

echo "Now terraform code will deploy all the VMs!!!"
ansible-playbook main.yml -t deploy_all_test_vms

echo "Now we configure listen ports in all the VMs"
configure_listen_ports_on_destinations() {
  local username=$(cat vars.yml | yq .hostname)
  local password=$(cat vars.yml | yq .defaultpassword)
  local source_script="listen-ports.sh"
  local destinations=$(cat vars.yml | yq .tkgm_vms_01[].ip; cat vars.yml | yq .tkgm_vms_02[].ip)

  for destination in $destinations; do
    # SCP the script file to the destination
    sshpass -p "$password" scp "$source_script" "$username@$destination:/home/k8s/listen-ports.sh"

    # SSH into the destination and execute the script
    sshpass -p "$password" ssh "$username@$destination" "chmod +x /home/k8s/listen-ports.sh; /home/k8s/listen-ports.sh"
  done
}

configure_listen_ports_on_destinations

echo "Now we copy the ssh_key of the mgmtclient VM to all the destination VMs!"
add_ssh_key_to_destinations() {
  local username=$(cat vars.yml | yq .hostname)
  local password=$(cat vars.yml | yq .defaultpassword)
  local source_script="my_ssh_key.sh"
  local public_key=$(cat /home/k8s/.ssh/id_rsa.pub)
  local destinations=$(cat vars.yml | yq .tkgm_vms_01[].ip; cat vars.yml | yq .tkgm_vms_02[].ip)

  # Print ssh_key
  # echo "$public_key"

  echo '#!/bin/bash' > /home/k8s/tkgm-validations/prod_code/my_ssh_key.sh
  echo 'sudo echo '$public_key' >> /home/k8s/.ssh/authorized_keys' >> /home/k8s/tkgm-validations/prod_code/my_ssh_key.sh

  for destination in $destinations; do
    # SCP the script file to the destination
    sshpass -p "$password" scp "$source_script" "$username@$destination:/home/k8s/my_ssh_key.sh"

    # SSH into the destination and execute the script
    sshpass -p "$password" ssh "$username@$destination" "chmod +x /home/k8s/my_ssh_key.sh; /home/k8s/my_ssh_key.sh"
  done
}

add_ssh_key_to_destinations

echo "Now we will test open ports in the following VMs!"
sleep 6

echo "Test open port on avi vm:"
ansible-playbook -i $vm_ip_tkgm_avi, -u k8s /home/k8s/tkgm-validations/prod_code/test_open_ports_code/run_on_avi_vm.yml

echo "Test open port on tkgm_mgmt vm:"
ansible-playbook -i $vm_ip_tkgm_mgmt, -u k8s /home/k8s/tkgm-validations/prod_code/test_open_ports_code/run_on_tkgm_mgmt_vm.yml

echo "Test open port on tkgm_workload vm:"
ansible-playbook -i $vm_ip_workload, -u k8s /home/k8s/tkgm-validations/prod_code/test_open_ports_code/run_on_tkgm_workload_vm.yml

echo "Test open port on tkgm_vip vm:"
ansible-playbook -i $vm_ip_tkgm_vip, -u k8s /home/k8s/tkgm-validations/prod_code/test_open_ports_code/run_on_tkgm_vip_vm.yml

echo "Test open port on tkgm_cp_vip vm:"
ansible-playbook -i $vm_ip_tkgm_cp_vip, -u k8s /home/k8s/tkgm-validations/prod_code/test_open_ports_code/run_on_tkgm_cp_vip_vm.yml

ansible-playbook /home/k8s/tkgm-validations/prod_code/test_open_ports_code/run_on_client_mgmt_vm.yml