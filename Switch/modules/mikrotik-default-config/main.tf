resource "routeros_interface_bridge" "bridge" {
  name      = "bridge"
  admin_mac = var.admin_mac
  auto_mac  = false
  comment   = "defconf"
}

locals {
  bridge_interfaces = concat(
    [for i in range(1, var.ether_count + 1) : "ether${i}"],
    var.extra_interfaces
  )
}

resource "routeros_interface_bridge_port" "ports" {
  for_each  = toset(local.bridge_interfaces)
  bridge    = routeros_interface_bridge.bridge.name
  interface = each.value
  comment   = "defconf"
}

resource "routeros_ip_address" "bridge_ip" {
  address   = var.bridge_ip
  interface = routeros_interface_bridge.bridge.name
  comment   = "defconf"
  network   = var.bridge_network
}

resource "routeros_system_routerboard_settings" "settings" {
  enter_setup_on = "delete-key"
}