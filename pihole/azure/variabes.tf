variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg_azu_e2_dns"
}

variable "app_name" {
  default = "pihole"
}

variable "image_name" {
  default = "pihole/pihole:latest"
}
