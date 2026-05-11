terraform {
  required_version = ">= 1.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "main" {
  name       = "hosting-platform-key"
  public_key = var.ssh_public_key
}

resource "hcloud_firewall" "main" {
  name = "hosting-platform-fw"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = var.allowed_ssh_cidrs
  }
}

resource "hcloud_server" "main" {
  name        = "hosting-platform"
  image       = "ubuntu-24.04"
  server_type = "cx33"
  location    = "fsn1"

  ssh_keys = [hcloud_ssh_key.main.id]

  firewall_ids = [hcloud_firewall.main.id]

  user_data = templatefile("${path.module}/cloud-init.yaml", {
    ghcr_username = var.ghcr_username
    ghcr_token    = var.ghcr_token
  })

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }
}
