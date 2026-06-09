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
  # Additional Mount Points (Disks)
  # ---------------------------------------------------------------------------
  dynamic "mount_point" {
    for_each = var.additional_disks
    content {
      volume = mount_point.value.volume
      size   = mount_point.value.size
      path   = mount_point.value.path
    }
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

# ---------------------------------------------------------------------------
# User Data (Provisioner)
# ---------------------------------------------------------------------------
# Resource ini hanya akan berjalan jika var.user_data tidak kosong.
# Memerlukan akses SSH ke container (port 22 terbuka dan reachable).
resource "null_resource" "lxc_userdata" {
  count = var.user_data != "" ? 1 : 0

  triggers = {
    user_data    = var.user_data
    container_id = proxmox_virtual_environment_container.container.id
  }

  provisioner "remote-exec" {
    inline = [var.user_data]

    connection {
      type     = "ssh"
      user     = "root"
      password = var.password
      host     = split("/", var.ip_address)[0]
    }
  }
}
