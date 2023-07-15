resource "avi_useraccount" "controller01" {
  username     = var.avi_username
  old_password = var.avi_default_password
  password     = var.avi_password
}

resource "avi_useraccount" "controller02" {
  provider = avi.controller02
  username     = var.avi_username
  old_password = var.avi_default_password
  password     = var.avi_password
}

resource "avi_useraccount" "controller03" {
  provider = avi.controller03
  username     = var.avi_username
  old_password = var.avi_default_password
  password     = var.avi_password
}