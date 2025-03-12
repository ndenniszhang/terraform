variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
  default     = "wordpress-rg"
}

variable "location" {
  description = "The Azure region"
  type        = string
  default     = "East US"
}

variable "db_name" {
  description = "The name of the MySQL database"
  type        = string
  default     = "wordpress_db"
}

variable "db_user" {
  description = "The username for the MySQL database"
  type        = string
  default     = "wordpress_user"
}

variable "db_password" {
  description = "The password for the MySQL database"
  type        = string
  sensitive   = true
}

variable "wordpress_image" {
  description = "The Docker image for WordPress"
  type        = string
  default     = "wordpress:latest"
}
