terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
  backend "s3" {
    bucket         = "terraform-state"    
    key            = "proxmox/terraform.tfstate"
    region         = "us-east-1"
    endpoints = { s3 = "http://docker-host.internal:9000" }

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}

provider "proxmox" {
  pm_api_url          = var.pve_api_url
  pm_api_token_id     = var.pve_token_id
  pm_api_token_secret = var.pve_token_secret
  pm_tls_insecure     = true
}

locals {
  vm_names = ["ansible-node-01", "ansible-node-02"]
}

module "web_servers" {
  source = "./modules/proxmox_vm"

  target_node     = "pve01"
  clone           = "ubuntu-cloudinit"
  count           = length(local.vm_names)
  vmid            = 300 + count.index
  name            = local.vm_names[count.index]

  ci_user         = "ubuntu"
  ci_ipv4_cidr    = "192.168.20.10${count.index}/24"
  ci_ipv4_gateway = "192.168.20.1"
  ci_ssh_key      = <keys>
}

output "id" {
  value = module.web_servers[*].id
}

output "public_ipv4" {
  value = module.web_servers[*].public_ipv4
}