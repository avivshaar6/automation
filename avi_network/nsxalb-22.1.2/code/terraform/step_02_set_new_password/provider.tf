terraform {
  required_providers {
    avi = {
      source = "vmware/avi"
      version = "22.1.2"
    }
  }
}

provider "avi" {
  avi_username = var.avi_username
  avi_password = var.avi_default_password
  avi_controller = var.avi_ip_controller01
  avi_version = var.avi_version
}

provider "avi" {
  avi_username = var.avi_username
  avi_password = var.avi_default_password
  avi_controller = var.avi_ip_controller02
  avi_version = var.avi_version
  alias = "controller02"
}

provider "avi" {
  avi_username = var.avi_username
  avi_password = var.avi_default_password
  avi_controller = var.avi_ip_controller03
  avi_version = var.avi_version
  alias = "controller03"
}