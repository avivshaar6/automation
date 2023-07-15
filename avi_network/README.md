# NSXALB - TeraSky Automation for Tanzu Project

This project provides a ability to deploy Avi Network cluster for Tanzu project

## Key technology used

1. Ansible
2. Terraform

## Prerequisite:

1. Download Avi Network OVA.
2. Create content library and and upload the OVA file.
3. Create resocrce pool for Avi Network.
4. Fill in the variables file.

## Explanation of the code

The codes Consists of:
- Ansible that run all the terraform and ansible codes.
- Terraform folders:
  1. Step01 - Deploy three Avi controllers.
  2. Step02 - Apply all the three Avi controllers new password.
  3. Step03 - Create avi_config and create Avi cluster with VIP IP.
- Ansible folder have one playbook that run:
  1. Cretae vCenter cloud.
  2. create_default_route_mgmt (only in essentials license).
  3. Edit SE Group.
  4. Configure IPAM profile.
  5. Configure DNS profile (only in essentials license.
  6. Import controller certificate (Avi and root CA).
  7. Upgrade Avi network to the last build.

## Manual settings

When the script is finished running, you will need to configure manually:
- Cloud:
  1. Update the SE-Group in the cloud.
  2. Choose the content library from which the SE will be deployed
- Networks:
  1. Update the networks that will need to configure with DHCP.

Note: I will fix it in the next commit!
