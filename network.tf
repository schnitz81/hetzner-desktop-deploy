resource "hcloud_primary_ip" "primary" {
  name          = "primary_ip"
  datacenter    = "fsn1-dc14"
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
  labels = {
    "ip" : "primary"
  }
}
