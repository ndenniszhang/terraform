module "tls" {
  source       = "./acme"
  acme_url     = var.acme_url
  common_name  = var.common_name
  domain_name  = var.domain_name
  dns_provider = var.dns_provider
}

module "sdns" {
  source          = "./azure"
  certificate_pem = module.tls.certificate_pem
  private_key_pem = module.tls.private_key_pem
}

module "cdn" {
  source      = "./cloudflare"
  email       = var.email
  zone_id     = var.zone_id
  api_token   = var.api_token
  account_id  = var.account_id
  common_name = var.common_name
  ip_address  = module.sdns.container_ip
}
