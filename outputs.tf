# =============================================================================
# Root Outputs
# =============================================================================

# Tambahkan output di sini sesuai VM/CT yang aktif.
# Contoh:
# output "vm_docker" {
#   description = "VM 102 — Docker host"
#   value       = module.vms.vm_docker
# }

output "vm-test" {
  description = "VM test create via x/terraform"
  value       = module.vms.vm-test
}
