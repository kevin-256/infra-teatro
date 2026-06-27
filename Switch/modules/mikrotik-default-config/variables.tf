variable "admin_mac" {
  type        = string
  description = "MAC address del bridge"
}

variable "bridge_ip" {
  type        = string
  default     = "192.168.88.1/24"
  description = "IP address del bridge"
}

variable "bridge_network" {
  type        = string
  default     = "192.168.88.0"
  description = "Network del bridge"
}

variable "extra_interfaces" {
  type        = list(string)
  default     = []
  description = "Interfacce aggiuntive da aggiungere al bridge"
}

variable "ether_count" {
  type        = number
  default     = 24
  description = "Numero di porte ethernet"
}