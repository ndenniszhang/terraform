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
        "Microsoft.Network/virtualNetworks/subnets/action"
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
