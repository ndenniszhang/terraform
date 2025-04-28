variable "email" {
  description = "Account email"
  type        = string
  sensitive   = true
}

variable "account_id" {
  description = "Account ID"
  type        = string
  sensitive   = true
}

variable "api_token" {
  description = "API key"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "Zone ID"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "Domain name for the DNS record"
  type        = string
}

variable "common_name" {
  description = "Common name for the DNS record"
  type        = string
}

variable "ip_address" {
  description = "IP address for the DNS record"
  type        = string
}
