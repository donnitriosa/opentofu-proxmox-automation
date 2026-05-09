# =============================================================================
# Proxmox Connection
# =============================================================================

variable "proxmox_endpoint" {
  description = "Proxmox API endpoint URL"
  type        = string
}

variable "proxmox_username" {
  description = "Proxmox username (format: user@realm)"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Skip TLS certificate verification"
  type        = bool
  default     = true
}

# =============================================================================
# Common Settings
# =============================================================================

variable "target_node" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "default_bridge" {
  description = "Default network bridge for VMs and containers"
  type        = string
  default     = "vmbr1"
}

variable "default_storage" {
  description = "Default storage pool for VM/CT disks"
  type        = string
  default     = "local-lvm"
}

variable "gateway" {
  description = "Default network gateway"
  type        = string
  default     = "10.10.10.1"
}

variable "dns_servers" {
  description = "DNS server list"
  type        = list(string)
  default     = ["8.8.8.8", "1.1.1.1"]
}

variable "ssh_public_key" {
  description = "SSH public key (shared across VMs and containers)"
  type        = string
  default     = ""
}
