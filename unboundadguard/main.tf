module "tls" {
  source      = "./acme"
  acme_url    = var.acme_url
  common_name = var.common_name
  domain_name = var.domain_name
  email       = var.cloudflare_email
  api_token   = var.cloudflare_api_token
  cert_path   = var.acme_cert_path
  key_path    = var.acme_key_path
}

module "dns" {
  source          = "./azure"
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  subscription_id = var.azure_subscription_id
  cert_path       = var.acme_cert_path
  key_path        = var.acme_key_path
  common_name     = var.common_name
}

module "cdn" {
  source      = "./cloudflare"
  email       = var.cloudflare_email
  zone_id     = var.cloudflare_zone_id
  api_token   = var.cloudflare_api_token
  account_id  = var.cloudflare_account_id
  common_name = var.common_name
  domain_name = var.domain_name
  ip_address  = module.dns.container_ip
}
