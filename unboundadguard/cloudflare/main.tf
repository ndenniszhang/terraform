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
  type    = "A"
  name    = "${var.common_name}.${var.domain_name}"
  content = var.ip_address
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "acme_challenge" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "_acme-challenge.${var.common_name}.${var.domain_name}"
  content = "" # This will be updated by the ACME provider during certificate issuance
  proxied = false
  ttl     = 1
}
