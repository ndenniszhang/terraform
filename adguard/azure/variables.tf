variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg_azu_e2_adguard"
}

variable "app_name" {
  description = "The name of the application"
  type        = string
  default     = "adguard"
}

variable "adguard_image" {
  description = "The Docker image for AdGuard Home"
  type        = string
  default     = "adguard/adguardhome:latest"
}

variable "work_path" {
  type    = string
  default = "/opt/adguardhome/work"
}

variable "conf_path" {
  type    = string
  default = "/opt/adguardhome/conf"
}

variable "unbound_image" {
  description = "The Docker image for Unbound"
  type        = string
  default     = "mvance/unbound:latest"
}

variable "unbound_conf_path" {
  type    = string
  default = "/opt/unbound/etc/unbound"
}
