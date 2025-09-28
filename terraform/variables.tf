variable "terraform_backend_path" {
  type = string
  sensitive = true
}

variable "proxmox_url" {
  type = string
  sensitive = true
}

variable "proxmox_token_id" {
  type = string
  sensitive = true
}

variable "proxmox_token_secret" {
  type = string
  sensitive = true
}