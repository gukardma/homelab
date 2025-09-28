terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
  backend "local" {
    path = var.terraform_backend_path
  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_url
  pm_api_token_id = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret

  pm_tls_insecure = true
}

