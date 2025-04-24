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

variable "dns_provider" {
  description = "DNS provider for ACME DNS challenge"
  type        = string
}
