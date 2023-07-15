variable "avi_username" {
  description = "Default user admin"
  type        = string
  default     = true
}

variable "avi_default_password" {
  description = "Default admin password"
  type        = string
  default     = true
}

variable "avi_password" {
  description = "Enter the new admin password"
  type        = string
}

variable "avi_ip_controller01" {
  description = "Avi controller01 IP"
  type        = string
}

variable "avi_ip_controller02" {
  description = "Avi controller02 IP"
  type        = string
}

variable "avi_ip_controller03" {
  description = "Avi controller03 IP"
  type        = string
}

variable "avi_version" {
  description = "Enter AVI version"
  type        = string
  default     = true
}