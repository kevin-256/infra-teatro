ntp_servers = ["ntp.ccpm", "jve.lab"]

devices = {
  crs326_foh = {
    host     = "192.168.88.1"
    name     = "crs326_foh"
    username = "admin"
    password = "admin"
  }
}

vlans = {
  dante_primary = 20
  dante_backup  = 30
  mixer_control = 40
  artnet        = 50
  video         = 60
}