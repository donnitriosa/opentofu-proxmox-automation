# =============================================================================
# Proxmox LXC Container Resource
# =============================================================================

terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_container" "container" {
  description   = var.description
  node_name     = var.target_node
  vm_id         = var.vmid
  tags          = sort(var.tags)
  unprivileged  = var.unprivileged
  start_on_boot = true
  started       = var.started

  # ---------------------------------------------------------------------------
  # Operating System
  # ---------------------------------------------------------------------------
  operating_system {
    template_file_id = var.ostemplate
    type             = "debian"
  }

  # ---------------------------------------------------------------------------
  # Initialization
  # ---------------------------------------------------------------------------
  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

    dns {
      servers = var.dns_servers
    }

    user_account {
      password = var.password != "" ? var.password : null
      keys     = var.ssh_public_keys
    }
  }

  # ---------------------------------------------------------------------------
  # CPU
  # ---------------------------------------------------------------------------
  cpu {
    cores = var.cores
  }

  # ---------------------------------------------------------------------------
  # Memory
  # ---------------------------------------------------------------------------
  memory {
    dedicated = var.memory
    swap      = var.swap
  }

  # ---------------------------------------------------------------------------
  # Root Disk
  # ---------------------------------------------------------------------------
  disk {
    datastore_id = var.storage
    size         = var.disk_size
  }

  # ---------------------------------------------------------------------------
  # Network
  # ---------------------------------------------------------------------------
  network_interface {
    name   = "eth0"
    bridge = var.bridge
  }

  # ---------------------------------------------------------------------------
  # Features
  # ---------------------------------------------------------------------------
  features {
    nesting = var.nesting
  }
}
