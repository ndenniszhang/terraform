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

variable "acme_url" {
  description = "ACME server URL"
  type        = string
  default     = "https://acme-staging-v02.api.letsencrypt.org/directory"
  # default = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "common_name" {
  description = "Common name for the certificate"
  type        = string
  default     = "sdns"
}

variable "domain_name" {
  description = "Domain name for the certificate"
  type        = string
  default     = "denniszhang.dev"
}

variable "dns_provider" {
  description = "DNS provider for ACME DNS challenge"
  type        = string
  default     = "cloudflare"
}
