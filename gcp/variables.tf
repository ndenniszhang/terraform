variable "project" {}

variable "region" {
  default = "us-east4"
}

variable "zone" {
  default = "us-east4-a"
}

variable "docker_image" {
  description = "pihole/pihole:latest"
}

variable "service_name" {
  description = "pihole-service"
}

variable "bucket_name" {
  description = "pihole-data"
}
