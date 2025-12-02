output "bucket" {
  value = minio_s3_bucket.homelab_state.bucket
}

output "minio_service_account_key" {
  value = minio_accesskey.service_account.access_key
}

output "minio_service_account_secret" {
  value     = minio_accesskey.service_account.secret_key
  sensitive = true
}