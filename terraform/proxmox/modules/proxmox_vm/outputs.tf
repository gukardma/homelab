output "id" {
  description = "Instance VM ID"
  value       = proxmox_vm_qemu.vm.id
}

output "public_ipv4" {
  description = "Instance Public IPv4 Address"
  value       = proxmox_vm_qemu.vm.default_ipv4_address
}