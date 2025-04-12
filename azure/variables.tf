variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg_azu_e2_aci"
}

variable "app_name" {
  type    = string
  default = "pihole"
}

variable "image_name" {
  type    = string
  default = "pihole/pihole:latest"
}

variable "mount_path" {
  type    = string
  default = "etc/pihole"
}

variable "timezone" {
  description = "The timezone for the container"
  type        = string
  default     = "UTC"
}
