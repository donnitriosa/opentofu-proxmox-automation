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

output "vm_test" {
   description = "vm untuk test create via terraform"
   value = {
     id = module.vm_test.vm_id
     ip = module.vm_test.ip_address
   }
}