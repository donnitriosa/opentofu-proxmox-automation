output "vm_id" {
  description = "The VM ID"
  value       = proxmox_virtual_environment_vm.vm.vm_id
}

output "name" {
  description = "The VM name"
  value       = proxmox_virtual_environment_vm.vm.name
}

output "ip_address" {
  description = "The configured static IP address"
  value       = var.ip_address
}

output "ipv4_addresses" {
  description = "The VM IPv4 addresses reported by QEMU guest agent"
  value       = proxmox_virtual_environment_vm.vm.ipv4_addresses
}
