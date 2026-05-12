# =============================================================================
# VM Outputs
# =============================================================================

# Tambahkan output di sini saat membuat VM baru.
# Contoh:
# output "vm_example" {
#   description = "VM xxx — Example"
#   value = {
#     id = module.vm_example.vm_id
#     ip = module.vm_example.ip_address
#   }
# }

output "vm-test" {
  description = "VM test create via x/terraform"
  value = {
    id = module.vm-test.vm_id
    ip = module.vm-test.ip_address
  }
}
