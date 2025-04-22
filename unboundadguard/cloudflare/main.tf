terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.3.0"
    }
  }
}

provider "cloudflare" {
  email     = var.email
  api_token = var.api_token
}

resource "cloudflare_dns_record" "sdns" {
  zone_id = var.zone_id
  name    = "sdns"
  content = var.ip_address
  type    = "A"
  proxied = true
  ttl     = 1
}
