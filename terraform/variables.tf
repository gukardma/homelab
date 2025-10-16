## Provider Login Variables
variable "pve_token_id" {
  description = "ID of the Proxmox API token (e.g., terraform-prov@pve!my-token)."
  sensitive   = true
}

variable "pve_token_secret" {
  description = "Secret value for the Proxmox API toke."
  sensitive   = true
}

variable "pve_api_url" {
  description = "The full URL for the Proxmox API endpoint."
  type        = string
  sensitive   = true
  validation {
    condition     = can(regex("(?i)^http[s]?://.*/api2/json$", var.pve_api_url))
    error_message = "The API URL must be a valid endpoint, e.g., 'https://pve.example.com:8006/api2/json'."
  }
}