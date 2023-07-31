variable "servername" {
  type = string
  default = "cloud-server"
}

variable "hcloud_token" {
  sensitive = true  # Requires terraform >= 0.14
}

variable "sshkey_name" {

}
