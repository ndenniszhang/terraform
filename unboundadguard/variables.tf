variable "azure_subscription_id" {
  description = "Subscription ID"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Tenant ID"
  type        = string
  sensitive   = true
}

variable "azure_client_id" {
  description = "Client ID"
  type        = string
  sensitive   = true
}

variable "azure_client_secret" {
  description = "Client Secret"
  type        = string
  sensitive   = true
}

variable "cloudflare_email" {
  description = "Cloudflare account email"
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API key"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
  sensitive   = true
}

variable "acme_url" {
  description = "ACME server URL"
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory"
  # default     = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "common_name" {
  description = "Common name for the certificate"
  type        = string
  default     = "dns"
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
