terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}

locals {
  ip_pools = {
    for name, vlan in var.vlans : name => {
      vlan_id = vlan
      network = "10.69.${vlan}.0/24"
      ranges  = ["10.69.${vlan}.1-10.69.${vlan}.100"]
      gateway = "10.69.${vlan}.254"
      dns     = "10.69.${vlan}.254"
    }
  }
}

resource "routeros_ip_pool" "pools" {
  for_each = local.ip_pools

  name   = each.key
  ranges = each.value.ranges
}

# resource "routeros_ip_dhcp_server_network" "networks" {
#   for_each = local.ip_pools
  
#   address    = each.value.network
#   gateway    = each.value.gateway
#   dns_server = each.value.dns
# }