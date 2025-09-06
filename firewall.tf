resource "hcloud_firewall" "firewall" {
  // skip creation if port list is empty
  count = length(var.open_ports) > 0 ? 1 : 0
  name = "server-firewall"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  // rule to add all ports in the port list
  dynamic "rule" {
    for_each = var.open_ports
    content {
      direction = "in"
      protocol  = "tcp"
      port      = rule.value
      source_ips = [
        "0.0.0.0/0",
        "::/0"
      ]
    }
  }
}
