// Link a server to a primary IP
resource "hcloud_server" "server_1" {
  name        = var.servername 
  image       = "debian-13"
  server_type = "cax11"
  datacenter  = "fsn1-dc14"
  ssh_keys    = [data.hcloud_ssh_key.ssh_key_1.name]
  labels = {
    "server" : "1"
  }
  public_net {
    ipv4_enabled = true
    ipv4 = hcloud_primary_ip.primary.id
  }
}


data "hcloud_ssh_key" "ssh_key_1" {
  name = var.sshkey_name
}
