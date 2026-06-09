# =============================================================================
# Variables yang diterima dari root module (common settings saja)
# =============================================================================

variable "target_node" {
  description = "Proxmox node name"
  type        = string
}

variable "default_storage" {
  description = "Default storage pool"
  type        = string
}

variable "default_bridge" {
  description = "Default network bridge"
  type        = string
}

variable "gateway" {
  description = "Network gateway"
  type        = string
}

variable "dns_servers" {
  description = "DNS server list"
  type        = list(string)
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "snippet_storage" {
  description = "Default storage for snippets"
  type        = string
}
