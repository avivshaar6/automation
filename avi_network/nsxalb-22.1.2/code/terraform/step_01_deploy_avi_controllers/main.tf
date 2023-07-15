module "avi-alb-deployment-vsphere" {
  source  = "./modules/avi-alb-deployment-vsphere"

  controller_default_password = var.controller_default_password
  avi_version                 = var.avi_version
  controller_password         = var.controller_password
  controller_ha               = var.controller_ha
  vsphere_datacenter          = var.vsphere_datacenter
  content_library             = var.content_library
  vm_template                 = var.vm_template
  vm_datastore                = var.vm_datastore
  vm_resource_pool            = var.vm_resource_pool
  name_prefix                 = var.name_prefix
  dns_servers                 = var.dns_servers
  dns_search_domain           = var.dns_search_domain
  ntp_servers                 = var.ntp_servers
  se_mgmt_portgroup           = var.se_mgmt_portgroup
  se_mgmt_network             = var.se_mgmt_network
  controller_mgmt_portgroup   = var.controller_mgmt_portgroup
  configure_se_mgmt_network   = var.configure_se_mgmt_network
  compute_cluster             = var.compute_cluster
  vm_folder                   = var.vm_folder
  vsphere_user                = var.vsphere_user
  vsphere_password            = var.vsphere_password
  vsphere_server              = var.vsphere_server
  vsphere_avi_user            = var.vsphere_avi_user
  vsphere_avi_password        = var.vsphere_avi_password
  controller_ip               = var.controller_ip
  controller_netmask          = var.controller_netmask
  controller_gateway          = var.controller_gateway
  configure_ipam_profile      = var.configure_ipam_profile
}


