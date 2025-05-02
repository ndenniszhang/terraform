variable "acme_url" {
  description = "ACME server URL"
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory"
  # default     = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "acme_cert_path" {
  description = "The local path to the certificate file"
  type        = string
  default     = "./config/cert/certificate.pem"
}

variable "acme_key_path" {
  description = "The local path to the private key file"
  type        = string
  default     = "./config/cert/private_key.pem"
}

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

variable "azure_location" {
  description = "Region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "azure_resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg_azu_e2_dns"
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

variable "common_name" {
  description = "Common name for the certificate"
  type        = string
  default     = "dns"
}

variable "dns_provider" {
  description = "DNS provider for ACME DNS challenge"
  type        = string
  default     = "cloudflare"
}

variable "domain_name" {
  description = "Domain name for the certificate"
  type        = string
  default     = "denniszhang.dev"
}
