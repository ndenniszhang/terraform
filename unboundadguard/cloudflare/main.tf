provider "cloudflare" {
  email     = var.email
  api_token = var.api_token
  base_url  = var.domain
}

resource "cloudflare_dns_record" "sdns" {
  zone_id = var.zone_id
  name    = "sdns"
  content = azurerm_container_group.aci.ip_address
  type    = "A"
  proxied = true
}
