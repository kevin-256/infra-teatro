terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
  required_version = ">= 1.6.0"
}

resource "routeros_interface_bridge" "creating_bridge" {
  name = var.bridge_name
}

resource "routeros_interface_bridge_port" "trunk_ports" {
  for_each = { for i, v in var.trunks : v.port => v }

  interface         = each.value.name
  bridge            = routeros_interface_bridge.bridge.name
  frame_types       = "admit-only-vlan-tagged"
  ingress_filtering = true

  pvid = 1
}

resource "routeros_interface_bridge_port" "access_ports" {
  for_each = { for i, v in var.access_ports : v.port => v }

  interface   = each.value.name
  bridge      = routeros_interface_bridge.bridge.name
  frame-types = admit-only-untagged-and-priority-tagged
  pvid        = each.value.pvid
}

resource "routeros_interface_bridge_vlan" "vlan_trunks" {
  for_each = { for i, v in var.trunks : v.port => v }

  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = each.value.vlan_ids

  tagged   = [each.value.port, var.bridge_name]
}

resource "routeros_interface_bridge_vlan" "vlan_access" {
  for_each = { for i, v in var.access_ports : v.name => v }

  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [each.value.vlan_id]

  untagged = [each.value.name]
  tagged   = [var.bridge_name]
}

resource "routeros_interface_bridge" "enabling_vlan_filtering_bridge" {
  name = var.bridge_name

  vlan_filtering = true
  protocol_mode  = "rstp"
}

resource "routeros_interface_vlan" "virtual_vlan_interfaces" {
  for_each = var.vlans

  vlan_id   = each.value
  name      = "vlan-${each.key}"
  interface = var.bridge_name
}

# resource "routeros_ip_address" "vlan10_ip" {
#   address   = "192.168.10.1/24"
#   interface = routeros_interface_vlan.vlan10.name
# }