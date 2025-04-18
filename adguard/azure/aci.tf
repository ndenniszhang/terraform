resource "azurerm_container_group" "aci" {
  name                = "${var.app_name}aci"
  ip_address_type     = "Public"
  os_type             = "Linux"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_name_label      = var.app_name

  diagnostics {
    log_analytics {
      workspace_id  = azurerm_log_analytics_workspace.logs.workspace_id
      workspace_key = azurerm_log_analytics_workspace.logs.primary_shared_key
    }
  }

  container {
    name   = var.app_name
    image  = var.adguard_image
    cpu    = "1.0"
    memory = "1.0"

    # environment_variables = {
    #   TZ                   = "UTC"
    #   UPSTREAM_DNS_SERVERS = azurerm_container_group.aci.containers[1].ip_address
    # }

    ports {
      port     = 80
      protocol = "TCP"
    }

    # ports {
    #   port     = 53
    #   protocol = "UDP"
    # }

    ports {
      port     = 443
      protocol = "TCP"
    }

    ports {
      port     = 853
      protocol = "TCP"
    }

    volume {
      name                 = "adguardwork"
      mount_path           = "${var.adguard_path}/work"
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.adguard.name
    }

    volume {
      name                 = "adguardconf"
      mount_path           = "${var.adguard_path}/conf"
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.cadguardonf.name
    }
  }

  container {
    name   = "${var.app_name}unbound"
    image  = var.unbound_image
    cpu    = "1.0"
    memory = "1.0"

    commands = [
      "bash",
      "-c",
      "cd ${var.unbound_path} && ln -sf conf/*.conf . && /unbound.sh"
    ]

    ports {
      port     = 53
      protocol = "UDP"
    }

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
