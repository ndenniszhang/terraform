resource "azurerm_lb_rule" "lb_rule_dns_udp" {
  name                           = "${var.common_name}-rule-dns"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Udp"
  frontend_port                  = 53
  backend_port                   = 53
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.default.id]
  probe_id                       = azurerm_lb_probe.lb_probe_http.id
}

# resource "azurerm_lb_rule" "lb_rule_http" {
#   name                           = "${var.common_name}-rule-http"
#   loadbalancer_id                = azurerm_lb.default.id
#   frontend_ip_configuration_name = "PublicIPAddress"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.default.id]
#   probe_id                       = azurerm_lb_probe.lb_probe_http.id
# }

resource "azurerm_lb_probe" "lb_probe_http" {
  name                = "${var.common_name}-probe-http"
  loadbalancer_id     = azurerm_lb.default.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lb_rule_dnstls" {
  name                           = "${var.common_name}-rule-dot"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 853
  backend_port                   = 853
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.default.id]
  probe_id                       = azurerm_lb_probe.lb_probe_dnstls.id
}

resource "azurerm_lb_probe" "lb_probe_dnstls" {
  name                = "${var.common_name}-probe-dot"
  loadbalancer_id     = azurerm_lb.default.id
  protocol            = "Tcp"
  port                = 853
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lb_rule_https" {
  name                           = "${var.common_name}-rule-https"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.default.id]
  probe_id                       = azurerm_lb_probe.lb_probe_https.id
}

resource "azurerm_lb_probe" "lb_probe_https" {
  name                = "${var.common_name}-probe-https"
  loadbalancer_id     = azurerm_lb.default.id
  protocol            = "Tcp"
  port                = 443
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lb_rule_setup" {
  name                           = "${var.common_name}-rule-setup"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 3000
  backend_port                   = 3000
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.default.id]
  probe_id                       = azurerm_lb_probe.lb_probe_setup.id
}

resource "azurerm_lb_probe" "lb_probe_setup" {
  name                = "${var.common_name}-probe-setup"
  loadbalancer_id     = azurerm_lb.default.id
  protocol            = "Tcp"
  port                = 3000
  interval_in_seconds = 5
  number_of_probes    = 2
}
