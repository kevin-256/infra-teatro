variable "timezone" {
  type = string
  default = "Europe/Rome"
}

variable "bridge_name" {
  type    = string
  default = "bridge-lan"
}

variable "trunks" {
  description = "List of trunk ports"
  type = list(object({
    name = string
    vlan_ids = list(number)
  }))
}

variable "access_ports" {
  description = "Access ports configuration"
  type = list(object({
    name    = string
    pvid    = number
    vlan_id = number
  }))
}