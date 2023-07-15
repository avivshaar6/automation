output "controllers" {
  description = "AVI Controller Information"
  value = ([for key, value in local.controller_info : merge(
    { "name" = key },
    { "private_ip_address" = value }
    )
    ]
  )
}