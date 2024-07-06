terraform {
  required_version = ">= 1.9.0"
  required_providers {
    # Configure the Hetzner Cloud Provider
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.47.0"
    }
  }
    
}

provider "hcloud" {
  token = var.hcloud_token
}
