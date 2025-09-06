output "ipv4_address" {
  value = hcloud_server.server_1.ipv4_address
  description = "Print the provided ipv4 address."
}

# get firewall status 
locals {
   firewall_enabled = length(var.open_ports) > 0
}

output "firewall_enabled" {
  value       = local.firewall_enabled
  description = "Output to display whether the firewall is enabled."
}

output "open_ports" {
  value = local.firewall_enabled ? var.open_ports : []
  description = "List open ports, if any."
}

# ansible inventory
resource "local_file" "ansible_inventory" {
  filename = "inventory"
  content = <<-EOF
[servers]
server_1 ansible_host=${hcloud_server.server_1.ipv4_address} ansible_user=root
  EOF
}


