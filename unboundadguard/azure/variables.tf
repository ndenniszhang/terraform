variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Client ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Client Secret"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg_azu_e2_dns"
}

variable "common_name" {
  description = "The name of the application"
  type        = string
}

variable "adguard_image" {
  description = "The Docker image for AdGuard Home"
  type        = string
  default     = "adguard/adguardhome:latest"
}

variable "adguard_path" {
  description = "The path in AdGuard container to persist"
  type        = string
  default     = "/opt/adguardhome"
}

variable "unbound_image" {
  description = "The Docker image for Unbound"
  type        = string
  default     = "mvance/unbound:latest"
}

variable "unbound_path" {
  description = "The path in Unbound conainer to persist"
  type        = string
  default     = "/opt/unbound/etc/unbound"
}

variable "cert_path" {
  description = "The local path to the certificate file"
  type        = string
}

variable "key_path" {
  description = "The local path to the private key file"
  type        = string
}
