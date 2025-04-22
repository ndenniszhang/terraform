variable "email" {
  description = "Cloudflare account email"
  type        = string
  default     = ""
}

variable "api_key" {
  description = "Cloudflare API key"
  type        = string
  default     = ""
}

variable "zone_id" {
  description = "Cloudflare zone ID"
  type        = string
  default = "<YOUR_ZONE_ID>"
}

variable "account_id" {
  description = "Cloudflare account ID"
  type        = string
  default = "<YOUR_ACCOUNT_ID>"
}

variable "domain" {
  description = "Domain name for the DNS record"
  type        = string
  default = "<YOUR_DOMAIN>"
}
