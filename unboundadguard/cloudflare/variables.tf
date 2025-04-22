variable "email" {
  description = "Cloudflare account email"
  type        = string
  sensitive   = true
}

variable "api_token" {
  description = "Cloudflare API key"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "Cloudflare zone ID"
  type        = string
  sensitive   = true
}

variable "account_id" {
  description = "Cloudflare account ID"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "Domain name for the DNS record"
  type        = string
  default     = "denniszhang.dev"
}
