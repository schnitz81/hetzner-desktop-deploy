output "ipv4_address" {
  value = hcloud_server.server_1.ipv4_address
}


# ansible inventory
resource "local_file" "ansible_inventory" {
  filename = "inventory"
  content = <<-EOF
[servers]
server_1 ansible_host=${hcloud_server.server_1.ipv4_address} ansible_user=root
  EOF
}


