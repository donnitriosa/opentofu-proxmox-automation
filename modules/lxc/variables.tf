variable "hostname" {
  description = "Container hostname"
  type        = string
}

variable "vmid" {
  description = "Container ID"
  type        = number
}

variable "target_node" {
  description = "Proxmox node name"
  type        = string
}

variable "ostemplate" {
  description = "OS template file ID (e.g., local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst)"
  type        = string
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 512
}

variable "swap" {
  description = "Swap in MB"
  type        = number
  default     = 512
}

variable "disk_size" {
  description = "Root disk size in GB"
  type        = number
  default     = 8
}

variable "storage" {
  description = "Storage pool for root disk"
  type        = string
  default     = "local-lvm"
}

variable "additional_disks" {
  description = "List of additional disks/mount points. PERINGATAN: Jangan pernah menurunkan ukuran disk (shrink) karena tidak disupport Proxmox dan bisa merusak data."
  type = list(object({
    volume = string # Storage pool name (e.g. "local-lvm") atau existing volume
    size   = string # Size dengan satuan (e.g. "10G")
    path   = string # Path mount point di dalam container (e.g. "/mnt/data")
  }))
  default = []
}

variable "bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr1"
}

variable "ip_address" {
  description = "Static IP with CIDR notation (e.g., 10.10.10.101/24)"
  type        = string
}

variable "gateway" {
  description = "Network gateway IP"
  type        = string
}

variable "dns_servers" {
  description = "List of DNS servers"
  type        = list(string)
  default     = ["8.8.8.8", "1.1.1.1"]
}

variable "password" {
  description = "Root password for the container"
  type        = string
  sensitive   = true
  default     = ""
}

variable "ssh_public_keys" {
  description = "List of SSH public keys"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Container description"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Container tags"
  type        = list(string)
  default     = []
}

variable "nesting" {
  description = "Enable nesting feature (required for Docker-in-LXC)"
  type        = bool
  default     = true
}

variable "unprivileged" {
  description = "Run as unprivileged container"
  type        = bool
  default     = true
}

variable "started" {
  description = "Start container after creation"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User-data script to run after container creation (requires SSH)"
  type        = string
  default     = ""
}
