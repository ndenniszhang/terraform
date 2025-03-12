variable "project_id" {
  description = "The GCP project ID"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "db_name" {
  description = "The name of the Cloud SQL database"
  type        = string
  default     = "wordpress_db"
}

variable "db_user" {
  description = "The username for the Cloud SQL database"
  type        = string
  default     = "wordpress_user"
}

variable "db_password" {
  description = "The password for the Cloud SQL database"
  type        = string
  sensitive   = true
}

variable "wordpress_image" {
  description = "The Docker image for WordPress"
  type        = string
  default     = "wordpress:latest"
}

variable "debug" {
  description = "Will enable WP_DEBUG in wp-config.php"
  type        = int
  default     = 1
}
