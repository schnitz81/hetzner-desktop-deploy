variable "servername" {
  type = string
  default = "cloud-server"
}

variable "hcloud_token" {
  sensitive = true
}

variable "sshkey_name" {

}

variable "open_ports" {
  type = set(string)
  default = []
}
