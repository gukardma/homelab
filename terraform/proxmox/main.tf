locals {
  vm_names = ["ansible-node-00"]
}

module "vm" {
  source = "./modules/proxmox_vm"

  target_node = var.target_node
  clone       = var.clone_template
  count       = length(local.vm_names)
  vmid        = 300 + count.index
  name        = local.vm_names[count.index]

  ci_user         = var.ci_user
  ci_ipv4_cidr    = "192.168.20.10${count.index}/24"
  ci_ipv4_gateway = var.ci_ipv4_gateway
  ci_ssh_key      = var.ci_ssh_keys
}