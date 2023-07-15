terraform {
  required_providers {
    avi = {
      source  = "vmware/avi"
      version = "22.1.2"
    }
  }
}

provider "avi" {
  avi_username    = var.avi_username
  avi_password    = var.avi_password
  avi_controller  = var.avi_ip_controller01
  avi_version     = var.avi_version
  avi_api_timeout = 50
}

#Test

provider "time" {}