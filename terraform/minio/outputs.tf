output "config" {
  value = {
    bucket         = module.proxmox_remote_state.bucket
    service_key    = module.proxmox_remote_state.minio_service_account_key
    service_secret = module.proxmox_remote_state.minio_service_account_secret
  }
  sensitive = true
}