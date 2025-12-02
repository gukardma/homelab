variable "ci_ssh_keys" {
  description = "SSH public keys for cloud-init"
  type        = string
  sensitive   = true
  default     = ""
}

variable "target_node" {
  description = "Proxmox target node"
  type        = string
  default     = "pve01"
}

variable "clone_template" {
  description = "Template to clone from"
  type        = string
  default     = "ubuntu-cloudinit"
}

variable "ci_user" {
  description = "Cloud-init user"
  type        = string
  default     = "ubuntu"
}

variable "ci_ipv4_gateway" {
  description = "IPv4 gateway for cloud-init"
  type        = string
  default     = "192.168.20.1"
}