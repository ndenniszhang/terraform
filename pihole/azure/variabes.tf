variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg_azu_e2_pihole"
}

variable "app_name" {
  type        = string
  default = "pihole"
}

variable "image_name" {
  type        = string
  default = "pihole/pihole:latest"
}

variable "timezone" {
  type        = string
  default = "US/Eastern"
}

variable "password" {
  description = "Password for web interface"
  type        = string
  sensitive = true
}