module "sdns" {
  source = "./azure"
}

module "cdn" {
  source     = "./cloudflare"
  zone_id    = var.zone_id
  email      = var.email
  account_id = var.account_id
  api_token  = var.api_token
  ip_address = module.sdns.container_ip
}
