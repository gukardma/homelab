variable "name" {
  type = string

  validation {
    condition     = var.name != "" && lower(var.name) == var.name
    error_message = "Names must be defined and contain all lower case characters."
  }
}

variable "target_user" {
  type      = string
  sensitive = true
}

locals {
  s3_bucket_name = format("tf-%s-state-bucket", var.name)
}