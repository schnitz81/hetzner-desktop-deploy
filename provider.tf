terraform {
  required_version = ">= 0.14.0"
  required_providers {
    # Configure the Hetzner Cloud Provider
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.39.0"
    }
  }
    
}

provider "hcloud" {
  token = var.hcloud_token
}
