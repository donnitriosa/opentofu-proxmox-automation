output "container_id" {
  description = "The container ID"
  value       = proxmox_virtual_environment_container.container.vm_id
}

output "hostname" {
  description = "The container hostname"
  value       = var.hostname
}

output "ip_address" {
  description = "The configured static IP address"
  value       = var.ip_address
}
