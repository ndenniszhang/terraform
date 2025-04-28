variable "acme_url" {
  description = "ACME server URL"
  type        = string
}

variable "common_name" {
  description = "Common name for the certificate"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the certificate"
  type        = string
}

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
