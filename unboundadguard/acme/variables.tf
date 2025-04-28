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

variable "cert_path" {
  description = "The local path to the certificate file"
  type        = string
}

variable "key_path" {
  description = "The local path to the private key file"
  type        = string
}
