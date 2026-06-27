terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
  required_version = ">= 1.6.0"
}

resource "routeros_interface_bridge" "bridge" {
  name           = "bridge"
  admin_mac      = "04:F4:1C:EB:2B:B9"
}

resource "routeros_interface_bridge_port" "bridge_ports" {
  for_each = {
    "ether1"       = { comment = "", pvid = "1" }
    "ether2"       = { comment = "", pvid = "1" }
    "ether3"       = { comment = "", pvid = "1" }
    "ether4"       = { comment = "", pvid = "1" }
    "ether5"       = { comment = "", pvid = "1" }
    "ether6"       = { comment = "", pvid = "1" }
    "ether7"       = { comment = "", pvid = "1" }
    "ether8"       = { comment = "", pvid = "1" }
    "ether9"       = { comment = "", pvid = "1" }
    "ether10"      = { comment = "", pvid = "1" }
    "ether11"      = { comment = "", pvid = "1" }
    "ether12"      = { comment = "", pvid = "1" }
    "ether13"      = { comment = "", pvid = "1" }
    "ether14"      = { comment = "", pvid = "1" }
    "ether15"      = { comment = "", pvid = "1" }
    "ether16"      = { comment = "", pvid = "1" }
    "ether17"      = { comment = "", pvid = "1" }
    "ether18"      = { comment = "", pvid = "1" }
    "ether19"      = { comment = "", pvid = "1" }
    "ether20"      = { comment = "", pvid = "1" }
    "ether21"      = { comment = "", pvid = "1" }
    "ether22"      = { comment = "", pvid = "1" }
    "ether23"      = { comment = "", pvid = "1" }
    "ether24"      = { comment = "", pvid = "1" }
    "sfp-sfpplus1" = { comment = "", pvid = "1" }
    "sfp-sfpplus2" = { comment = "", pvid = "1" }
  }

  bridge    = routeros_interface_bridge.bridge.name
  interface = each.key
  comment   = each.value.comment
  pvid      = each.value.pvid
}

import {
  for_each = {
    "ether1"  = { id = "*0" }
    "ether2"  = { id = "*1" }
    "ether3"  = { id = "*2" }
    "ether4"  = { id = "*3" }
    "ether5"  = { id = "*4" }
    "ether6"  = { id = "*5" }
    "ether7"  = { id = "*6" }
    "ether8"  = { id = "*7" }
    "ether9"  = { id = "*8" }
    "ether10" = { id = "*9" }
    "ether11" = { id = "*A" }
    "ether12" = { id = "*B" }
    "ether13" = { id = "*C" }
    "ether14" = { id = "*D" }
    "ether15" = { id = "*E" }
    "ether16" = { id = "*F" }
    "ether17" = { id = "*10" }
    "ether18" = { id = "*11" }
    "ether19" = { id = "*12" }
    "ether20" = { id = "*13" }
    "ether21" = { id = "*14" }
    "ether22" = { id = "*15" }
    "ether23" = { id = "*16" }
    "ether24" = { id = "*17" }
    "sfp-sfpplus1" = { id = "*18" }
    "sfp-sfpplus2" = { id = "*19" }
  }

  to = routeros_interface_bridge_port.bridge_ports[each.key]
  id = each.value.id
}

import {
  to = routeros_ip_address.lan
  id = "192.168.88.1/24"
}
resource "routeros_ip_address" "lan" {
  address   = "192.168.88.1/24"
  interface = routeros_interface_bridge.bridge.name
  network   = "192.168.88.0"
}


resource "routeros_system_routerboard_settings" "this" {
  enter_setup_on = "delete-key"
}
# resource "routeros_interface_bonding" "uplink" {
#   provider = routeros.crs326_foh

#   name   = "bond-uplink"
#   mode   = "802.3ad"
#   slaves = ["ether21","ether22"]

#   transmit_hash_policy = "layer-2-and-3"
#   lacp_rate            = "1sec"
# }