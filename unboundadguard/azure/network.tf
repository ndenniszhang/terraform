resource "azurerm_virtual_network" "vnet" {
  name                = "${var.common_name}vnet${random_id.rand.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/29"]
}

resource "azurerm_subnet" "aci_subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/29"]

  delegation {
    name = "aci-delegation"

    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_public_ip" "static_ip" {
  name                = "${var.common_name}staticip${random_id.rand.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "default" {
  name                = "${var.common_name}loadbalancer${random_id.rand.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.static_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "default" {
  name            = "${var.common_name}-address-pool"
  loadbalancer_id = azurerm_lb.default.id
}

resource "azurerm_lb_rule" "lb_rule_dns_udp" {
  name                           = "${var.common_name}-rule-dns-udp"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Udp"
  frontend_port                  = 53
  backend_port                   = 53
}

# resource "azurerm_lb_rule" "lb_rule_http" {
#   name                           = "${var.common_name}-rule-http"
#   loadbalancer_id                = azurerm_lb.default.id
#   frontend_ip_configuration_name = "PublicIPAddress"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   # probe_id                       = azurerm_lb_probe.lb_probe_http.id
# }

# resource "azurerm_lb_probe" "lb_probe_http" {
#   name                = "${var.common_name}-probe-http"
#   resource_group_name = azurerm_resource_group.rg.name
#   loadbalancer_id     = azurerm_lb.lb.id
#   protocol            = "Tcp"
#   port                = 80
#   interval_in_seconds = 5
#   number_of_probes    = 2
# }

resource "azurerm_lb_rule" "lb_rule_dnstls" {
  name                           = "${var.common_name}-rule-dnstls"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 853
  backend_port                   = 853
  # probe_id                       = azurerm_lb_probe.lb_probe_https.id
}

resource "azurerm_lb_rule" "lb_rule_https" {
  name                           = "${var.common_name}-rule-https"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  # probe_id                       = azurerm_lb_probe.lb_probe_https.id
}

# resource "azurerm_lb_probe" "lb_probe_https" {
#   name                = "${var.common_name}-probe-https"
#   resource_group_name = azurerm_resource_group.rg.name
#   loadbalancer_id     = azurerm_lb.lb.id
#   protocol            = "Tcp"
#   port                = 443
#   interval_in_seconds = 5
#   number_of_probes    = 2
# }

resource "azurerm_lb_rule" "lb_rule_setup" {
  name                           = "${var.common_name}-rule-setup"
  loadbalancer_id                = azurerm_lb.default.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 3000
  backend_port                   = 3000
}
