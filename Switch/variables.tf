variable "ntp_servers" {
  type = list(string)
}

variable "devices" {
  type = map(object({
    name     = string
    host     = string
    username = string
    password = string
  }))

  validation {
    condition = contains(keys(var.devices), "crs326_foh")
    error_message = "You must define devices.crs326_foh in your tfvars file."
  }
}

variable "vlans" {
  type = map(number)
}
