output "bridge_name" {
  value = routeros_interface_bridge.bridge.name
}

output "bridge_ip" {
  value = routeros_ip_address.bridge_ip.address
}