variable "bridge_name" {
  type = string
  default = "bridge"
}

variable "ntp_servers" {
  type = list(string)
}

variable "new_admin_username" {
  type = string
}

variable "new_admin_password" {
  type = string
  sensitive = true
}

variable "vlans" {
  type = map(number)
}

variable "trunks" {
  type = list(
    object({
      port = string
      vlan_ids = list(number)
    })
  )
}

variable access_ports {
  type = list(
    object({
      port = string
      pvid = list(number)
    })
  )
}