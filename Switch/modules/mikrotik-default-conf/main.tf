terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
  required_version = ">= 1.6.0"
}

resource "routeros_system_identity" "this" {
  name = each.name
}
resource "routeros_system_clock" "this" {
  time_zone_name = var.timezone
}
resource "routeros_system_ntp_client" "this" {
  enabled = true
  servers = var.ntp_servers
}

resource "routeros_user" "admin" {
  name     = var.new_admin_username
  password = var.new_admin_password
  group    = "full"
}