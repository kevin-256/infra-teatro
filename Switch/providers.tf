provider "routeros" {
  alias    = "crs326_foh"
  hosturl  = "http://${var.devices["crs326_foh"].host}"
  username = var.devices["crs326_foh"].username
  password = var.devices["crs326_foh"].password
}