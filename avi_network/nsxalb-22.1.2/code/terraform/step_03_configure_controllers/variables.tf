variable "avi_username" {
  description = "avi user name (Usually admin is used)"
  type        = string
}

variable "avi_password" {
  description = "avi user password"
  type        = string
}

variable "avi_cluster_vip" {
  description = "Enter avi cluster IP"
  type        = string
}

variable "avi_ip_controller01" {
  type = string
}

variable "avi_ip_controller02" {
  type = string
}

variable "avi_ip_controller03" {
  type = string
}

variable "avi_hostname_controller01" {
  type = string
}

variable "avi_hostname_controller02" {
  type = string
}

variable "avi_hostname_controller03" {
  type = string
}

variable "avi_version" {
  description = "avi version"
  type        = string
}

variable "ip_type" {
  description = "IP4V / IPV6"
  default     = "V4"
  type        = string
}

variable "avi_cluster_name" {
  type = string
}

variable "avi_dns_server_ips" {
  description = "DNS list"
  type        = list(any)
}

variable "avi_ntp_server_ips" {
  description = "NTP list"
  type        = list(any)

}

variable "default_license_tier" {
  description = "Options - ENTERPRISE_16, ENTERPRISE, ENTERPRISE_18, BASIC, ESSENTIALS, ENTERPRISE_WITH_CLOUD_SERVICES."
  type        = string
}

variable "disable_tls" {
  default = false
  type    = bool
}

variable "from_email" {
  description = "from whom to send avi emails"
  type        = string
}

variable "mail_server_name" {
  description = "Default value"
  type        = string
}

variable "mail_server_port" {
  description = "Default value"
  default     = 25
  type        = number
}

variable "smtp_type" {
  description = "Default value"
  default     = "SMTP_LOCAL_HOST"
  type        = string
}

variable "banner" {
  type = string
}

variable "search_domain" {
  type = string
}