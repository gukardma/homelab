locals {
  vm_names = ["ansible-node-00"]
}

module "vm" {
  source = "./modules/proxmox_vm"

  target_node = "pve01"
  clone       = "ubuntu-cloudinit"
  count       = length(local.vm_names)
  vmid        = 300 + count.index
  name        = local.vm_names[count.index]

  ci_user         = "ubuntu"
  ci_ipv4_cidr    = "192.168.20.10${count.index}/24"
  ci_ipv4_gateway = "192.168.20.1"
  ci_ssh_key      = <<EOF
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtLipDkji+y8oQlbUy1Ai0Wf0xa2wRXaAW0ZLmmbjo9 guichard@gumani
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPi3OwaJ8oztZ7cWtldji1bc06d5DSit8L47x/ge79fc ubuntu@gumani
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAVoklkY0ze+c2vAL8xp7fPeeujbOilYOnt8eZPmkNdO guichard@xps
                    EOF
}