resource "azurerm_container_group" "aci" {
  name                = "${var.common_name}aci${random_id.rand.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  # ip_address_type     = "Private"
  # subnet_ids = [azurerm_subnet.aci_subnet.id]

  diagnostics {
    log_analytics {
      workspace_id  = azurerm_log_analytics_workspace.logs.workspace_id
      workspace_key = azurerm_log_analytics_workspace.logs.primary_shared_key
    }
  }

  container {
    name   = "${var.common_name}adguard"
    image  = var.adguard_image
    cpu    = "1.0"
    memory = "1.0"

    ports {
      port     = 53
      protocol = "UDP"
    }

    ports {
      port     = 80
      protocol = "TCP"
    }

    ports {
      port     = 443
      protocol = "TCP"
    }

    ports {
      port     = 853
      protocol = "TCP"
    }

    # used for initial setup can be disabled after setup
    # ports {
    #   port     = 3000
    #   protocol = "TCP"
    # }

    volume {
      name                 = "adguardconf"
      mount_path           = "${var.adguard_path}/conf"
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.adguard.name
    }

    volume {
      name                 = "adguardwork"
      mount_path           = "${var.adguard_path}/work"
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.adguard.name
    }
  }

  container {
    name   = "${var.common_name}unbound"
    image  = var.unbound_image
    cpu    = "1.0"
    memory = "1.0"

    commands = [
      "bash",
      "-c",
      "cd ${var.unbound_path} && ln -sf conf/*.conf . && /unbound.sh"
    ]

    ports {
      port     = 5353
      protocol = "UDP"
    }

    # for remote administration
    # ports {
    #   port     = 8953
    #   protocol = "UDP"
    # }

    volume {
      name                 = "unboundconf"
      mount_path           = "${var.unbound_path}/conf"
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.unbound.name
    }
  }
}

# resource "azurerm_network_profile" "aci_profile" {
#   name                = "${var.common_name}netprofile${random_id.rand.hex}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   container_network_interface {
#     name = "aci-nic"

#     ip_configuration {
#       name      = "aci-ipconfig"
#       subnet_id = azurerm_subnet.aci_subnet.id
#     }
#   }
# }

# resource "azurerm_lb_backend_address_pool_address" "backend_address" {
#   name                    = "${var.common_name}-backend-address"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.default.id
#   ip_address              = azurerm_container_group.aci.ip_address
# }
