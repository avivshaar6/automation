# Tanzu Validation Project - TeraSky Automation for Tanzu Project

This script is designed to check the opening of ports between machines that sit on different networks (the Tanzu VMs will going to be deployed there) and tells which ports are open and which are not.
This script is designed to run before the installation of Tanzu at the customer on 5 new test machines that will be deployed at the customer, which will allow us a simple installation in a minimum of time.

## Key technology used

1. Bash
2. Ansible

## Prerequisite:

1. Install ansible.
2. Deploy five new test VMs in each Tanzu network (I will upload the update codes with that section).

## Explanation of the code

The codes Consist of:
- Terraform:
  1. Deploy five test VMs in each Tanzu network.
- Bash:
  1. Create '/etc/ansible/hosts' file with all the test VMs IPs.
  2. Deploy all the five test VMs.
  3. Configure all the listen ports in all the five VMs and run the listen-ports.sh.
  4. Copy the ssh_key of the mgmt client VM to all the destination VMs.
  5. Run from the mgmt client the ansible codes that test if the ports are open.