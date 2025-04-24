terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "2.32.0"
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
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = "${var.common_name}.${var.domain_name}"
  subject_alternative_names = ["*.${var.domain_name}", var.domain_name]

  dns_challenge {
    provider = var.dns_provider
  }
}
