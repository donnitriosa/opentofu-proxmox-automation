variable "name" {
  description = "VM name"
  type        = string
}

variable "vmid" {
  description = "VM ID"
  type        = number
}

variable "target_node" {
  description = "Proxmox node name"
  type        = string
}

variable "clone_template_id" {
  description = "Template VM ID to clone from"
  type        = number
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "storage" {
  description = "Storage pool for disk"
  type        = string
  default     = "local-lvm"
}

variable "additional_disks" {
  description = "List of additional disks (contoh: storage kedua, dst). PERINGATAN: Jangan pernah menurunkan ukuran disk (shrink) karena tidak disupport Proxmox dan bisa merusak data."
  type = list(object({
    datastore_id = string
    size         = number
    file_format  = optional(string, "raw")
    interface    = optional(string)
  }))
  default = []
}

variable "bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr1"
}

variable "ip_address" {
  description = "Static IP with CIDR notation (e.g., 10.10.10.102/24)"
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

variable "ci_user" {
  description = "Cloud-init username"
  type        = string
  default     = "debian"
}

variable "ci_password" {
  description = "Cloud-init user password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "ssh_public_key" {
  description = "SSH public key for cloud-init"
  type        = string
  default     = ""
}

variable "description" {
  description = "VM description"
  type        = string
  default     = ""
}

variable "tags" {
  description = "VM tags"
  type        = list(string)
  default     = []
}

variable "started" {
  description = "Start VM after creation"
  type        = bool
  default     = true
}
