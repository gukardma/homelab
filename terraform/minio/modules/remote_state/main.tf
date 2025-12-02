resource "minio_accesskey" "service_account" {
  user   = var.target_user
  policy = data.minio_iam_policy_document.state_policy.json
}

data "minio_iam_policy_document" "state_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${minio_s3_bucket.homelab_state.bucket}"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::${minio_s3_bucket.homelab_state.bucket}/*"]
  }
}

resource "minio_s3_bucket" "homelab_state" {
  bucket = local.s3_bucket_name
}

resource "minio_s3_bucket_versioning" "bucket_versioning" {
  bucket = minio_s3_bucket.homelab_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}