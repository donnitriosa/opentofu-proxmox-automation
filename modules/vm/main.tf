# =============================================================================
# Proxmox VM Resource (Clone from Cloud-Init Template)
# =============================================================================

terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.name
  node_name   = var.target_node
  vm_id       = var.vmid
  description = var.description
  tags        = sort(var.tags)

  on_boot = true
  started = var.started

  agent {
    enabled = true
  }

  # ---------------------------------------------------------------------------
  # Clone from template
  # ---------------------------------------------------------------------------
  clone {
    vm_id = var.clone_template_id
    full  = true
  }

  # ---------------------------------------------------------------------------
  # CPU
  # ---------------------------------------------------------------------------
  cpu {
    cores   = var.cores
    sockets = var.sockets
    type    = "x86-64-v2-AES"
  }

  # ---------------------------------------------------------------------------
  # Memory
  # ---------------------------------------------------------------------------
  memory {
    dedicated = var.memory
  }

  # ---------------------------------------------------------------------------
  # Disk
  # ---------------------------------------------------------------------------
  # Disk Utama (scsi0)
  disk {
    datastore_id = var.storage
    size         = var.disk_size
    interface    = "scsi0"
    discard      = "on"
    ssd          = true
  }

  # Disk Tambahan (scsi1, scsi2, dst)
  dynamic "disk" {
    for_each = var.additional_disks
    content {
      datastore_id = disk.value.datastore_id
      size         = disk.value.size
      interface    = coalesce(disk.value.interface, "scsi${disk.key + 1}")
      file_format  = disk.value.file_format
      discard      = "on"
      ssd          = true
    }
  }

  # ---------------------------------------------------------------------------
  # Network
  # ---------------------------------------------------------------------------
  network_device {
    bridge = var.bridge
    model  = "virtio"
  }

  # ---------------------------------------------------------------------------
  # Cloud-Init Configuration
  # ---------------------------------------------------------------------------
  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

    user_account {
      username = var.ci_user
      password = var.ci_password != "" ? var.ci_password : null
      keys     = var.ssh_public_key != "" ? [var.ssh_public_key] : []
    }

    dns {
      servers = var.dns_servers
    }

    user_data_file_id = var.user_data != "" ? proxmox_virtual_environment_file.user_data[0].id : null
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_data_file_id,
    ]
  }
}

# =============================================================================
# User Data (Snippets)
# =============================================================================

resource "proxmox_virtual_environment_file" "user_data" {
  count = var.user_data != "" ? 1 : 0

  content_type = "snippets"
  datastore_id = var.datastore_id
  node_name    = var.target_node

  source_raw {
    data      = <<-EOT
#cloud-config
hostname: ${var.name}
manage_etc_hosts: true
fqdn: ${var.name}

chpasswd:
  expire: False

users:
  - default
  - name: ${var.ci_user}
    groups: sudo
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
%{ if var.ci_password != "" }
    password: ${var.ci_password}
    lock_passwd: false
%{ endif }
%{ if var.ssh_public_key != "" }
    ssh_authorized_keys:
      - ${trimspace(var.ssh_public_key)}
%{ endif }

${replace(var.user_data, "#cloud-config", "")}
EOT
    file_name = "user-data-${var.name}.yaml"
  }
}
