terraform {
  required_providers {
    proxmox = {
      # source = "bpg/proxmox"
      # version = "0.88.0"
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }

  backend "s3" {
    bucket = "tf-proxmox-state-bucket"
    key    = "terraform.tfstate"

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}