terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.22.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.app_name}storageacct"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
}

resource "azurerm_storage_share" "work" {
  name               = "${var.app_name}work"
  storage_account_id = azurerm_storage_account.storage.id
  quota              = 1 //GB
}

resource "azurerm_storage_share" "conf" {
  name               = "${var.app_name}conf"
  storage_account_id = azurerm_storage_account.storage.id
  quota              = 1 //GB
}

resource "azurerm_container_group" "aci" {
  name                = "${var.app_name}aci"
  ip_address_type     = "Public"
  os_type             = "Linux"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_name_label      = var.app_name

  # exposed_port {
  #   port     = 80
  #   protocol = "TCP"
  # }

  # exposed_port {
  #   port     = 443
  #   protocol = "TCP"
  # }

  # exposed_port {
  #   port     = 53
  #   protocol = "TCP"
  # }

  # container {
  #   name   = var.app_name
  #   image  = var.adguard_image
  #   cpu    = "1.0"
  #   memory = "1.0"

  #   environment_variables = {
  #     TZ                   = "UTC"
  #     UPSTREAM_DNS_SERVERS = azurerm_container_group.aci.containers[1].ip_address
  #   }

  #   ports {
  #     port     = 80
  #     protocol = "TCP"
  #   }

  #   ports {
  #     port     = 53
  #     protocol = "UDP"
  #   }

  #   ports {
  #     port     = 443
  #     protocol = "TCP"
  #   }

  #   ports {
  #     port     = 853
  #     protocol = "TCP"
  #   }

  #   volume {
  #     name                 = "workdir"
  #     mount_path           = var.work_path
  #     storage_account_name = azurerm_storage_account.storage.name
  #     storage_account_key  = azurerm_storage_account.storage.primary_access_key
  #     share_name           = azurerm_storage_share.work.name
  #   }

  #   volume {
  #     name                 = "confdir"
  #     mount_path           = var.conf_path
  #     storage_account_name = azurerm_storage_account.storage.name
  #     storage_account_key  = azurerm_storage_account.storage.primary_access_key
  #     share_name           = azurerm_storage_share.conf.name
  #   }
  # }

  container {
    name   = "${var.app_name}unbound"
    image  = var.unbound_image
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 53
      protocol = "UDP"
    }

    # ports {
    #   port     = 8953
    #   protocol = "UDP"
    # }
  }
}
