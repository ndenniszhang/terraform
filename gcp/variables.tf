variable "project_id" {}

variable "region" {
  default = "us-east4"
}

variable "zone" {
  default = "us-east4-a"
}

variable "timezone" {
  default = "US/Eastern"
}

variable "namespace" {
  default = "pihole"
}

variable "container_image" {
  default = "pihole/pihole:latest"
}

variable "service_name" {
  default = "pihole-service"
}

variable "pihole_password" {}

variable "upstream_dns" {
  default = "1.1.1.1;8.8.8.8"
}
