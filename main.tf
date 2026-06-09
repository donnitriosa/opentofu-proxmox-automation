# =============================================================================
# Main — Root Module
#
# Memanggil sub-module vms/ dan containers/ dan meneruskan
# common variables dari terraform.tfvars.
# =============================================================================

# -----------------------------------------------------------------------------
# Virtual Machines
# -----------------------------------------------------------------------------

module "vms" {
  source = "./vms"

  target_node     = var.target_node
  default_storage = var.default_storage
  default_bridge  = var.default_bridge
  gateway         = var.gateway
  dns_servers     = var.dns_servers
  ssh_public_key  = var.ssh_public_key
  snippet_storage = var.snippet_storage
}

# -----------------------------------------------------------------------------
# LXC Containers
# -----------------------------------------------------------------------------

module "containers" {
  source = "./containers"

  target_node     = var.target_node
  default_storage = var.default_storage
  default_bridge  = var.default_bridge
  gateway         = var.gateway
  dns_servers     = var.dns_servers
  ssh_public_key  = var.ssh_public_key
  snippet_storage = var.snippet_storage
}
