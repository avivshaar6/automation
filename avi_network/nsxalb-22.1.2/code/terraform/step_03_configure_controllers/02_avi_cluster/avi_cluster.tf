resource "avi_cluster" "avi_cluster" {
  # count            = length(var.avi_controller_ips) == 3 ? 1 : 0
  name = var.avi_cluster_name
  virtual_ip {
    addr = var.avi_cluster_vip
    type = var.ip_type
  }
  nodes {
    ip {
      type = var.ip_type
      addr = var.avi_ip_controller01
  }
  name = var.avi_hostname_controller01
  password = var.avi_password
}

  nodes {
    ip {
      type = var.ip_type
      addr = var.avi_ip_controller02
  }
  name = var.avi_hostname_controller02
  password = var.avi_password
}
  nodes {
    ip {
      type = var.ip_type
      addr = var.avi_ip_controller03
  }
  name = var.avi_hostname_controller03
  password = var.avi_password
}
}

# Wait until Avi controller get back
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Waiting for the cluster to be created, 5 minutes!'"
  }

  provisioner "local-exec" {
    command = "sleep 250"
  }

  provisioner "local-exec" {
    command = "echo 'Done waiting.'"
  }

  depends_on = [avi_cluster.avi_cluster]
}