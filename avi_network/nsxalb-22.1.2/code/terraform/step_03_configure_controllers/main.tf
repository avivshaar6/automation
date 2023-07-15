module "avi_config" {
  source = "./01_avi_config"

  default_license_tier = var.default_license_tier
  avi_dns_server_ips   = var.avi_dns_server_ips
  search_domain        = var.search_domain
  disable_tls          = var.disable_tls
  from_email           = var.from_email
  mail_server_name     = var.mail_server_name
  mail_server_port     = var.mail_server_port
  smtp_type            = var.smtp_type
  banner               = var.banner
  avi_ntp_server_ips   = var.avi_ntp_server_ips
  backup_passphrase    = var.avi_password
}

module "avi_cluster" {
  source = "./02_avi_cluster"

  avi_cluster_name          = var.avi_cluster_name
  avi_cluster_vip           = var.avi_cluster_vip
  avi_ip_controller01       = var.avi_ip_controller01
  avi_hostname_controller01 = var.avi_hostname_controller01
  avi_ip_controller02       = var.avi_ip_controller02
  avi_hostname_controller02 = var.avi_hostname_controller02
  avi_ip_controller03       = var.avi_ip_controller03
  avi_hostname_controller03 = var.avi_hostname_controller03
  avi_password              = var.avi_password
  ip_type                   = var.ip_type

  depends_on = [module.avi_config]
}