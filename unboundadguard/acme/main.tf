terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "2.32.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "acme" {
  server_url = var.acme_url
}

resource "acme_registration" "reg" {
  email_address = "junkmailforstupd@gmail.com"
}

resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "${var.common_name}.${var.domain_name}"
  # subject_alternative_names = [var.domain_name]

  dns_challenge {
    provider = "cloudflare"

    config = {
      CLOUDFLARE_EMAIL         = var.email
      CLOUDFLARE_DNS_API_TOKEN = var.api_token
    }
  }

  pre_check_delay              = 10
  recursive_nameservers        = ["10.231.0.7:53"]
  disable_complete_propagation = true
}

resource "local_sensitive_file" "certificate" {
  content  = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"
  filename = var.cert_path
}

resource "local_sensitive_file" "private_key" {
  content  = acme_certificate.certificate.private_key_pem
  filename = var.key_path
}
