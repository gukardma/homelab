terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "3.8.0"
    }
  }
  backend "s3" {
    bucket = "tf-homelab-state-bucket"
    key    = "terraform.tfstate"

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}