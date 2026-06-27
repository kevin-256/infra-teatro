terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
  required_version = ">= 1.6.0"
}

resource "routeros_interface_ethernet_switch_qos_profile" "creating_dante_ptp_profile" {
  name          = dante-ptp
  dscp          = 56
  pcp           = 7
  traffic_class = 7
}

resource "routeros_interface_ethernet_switch_qos_profile" "creating_dante_audio_profile" {
  name          = dante-audio
  dscp          = 46
  pcp           = 5
  traffic_class = 5
}

resource "routeros_interface_ethernet_switch_qos_tx_manager_queue" "enable_strict_priority_class_7" {
  traffic_class = 7
  schedule      = "strict-priority"
}

resource "routeros_interface_ethernet_switch_qos_tx_manager_queue" "enable_strict_priority_class_5" {
  traffic_class = 5
  schedule      = "strict-priority"
}

resource "routeros_interface_ethernet_switch_qos_port" "enable_trust_layer_3" {
  trust_l3 = "keep"
}

resource "routeros_interface_ethernet_switch" "enable_hardware_offloading" {
  name              = "switch1"
  qos_hw_offloading = true
}

#When using Dante in multicast mode, it is beneficial to enable IGMP snooping on the switch. This feature directs traffic only to ports with subscribed devices, preventing unnecessary flooding. Additionally, enabling an IGMP querier (if not already enabled on another device in the same LAN), adjusting query interval, and activating fast-leave can further optimize multicast performance.
# resource "routeros_interface_bridge" "bridge" {
#   name                 = "bridge"
#   igmp_snooping        = true
#   multicast_querier    = true
#   query_interval       = "60s"
# }
# resource "routeros_interface_bridge_port" "all" {
#   fast_leave = true
# }