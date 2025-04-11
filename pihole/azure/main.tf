terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.25.0"
    }
  }
}

provider "azurerm" {
  features {}

  # tenant_id       = var.tenant_id
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.app_name}storage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share" {
  name               = "${var.app_name}share"
  storage_account_id = azurerm_storage_account.storage.id
  quota              = 4
}

resource "azurerm_container_group" "aci" {
  name                = "${var.app_name}aci"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  dns_name_label      = var.app_name

  container {
    name   = var.app_name
    image  = var.image_name
    cpu    = "1.5"
    memory = "1.0"

    ports {
      port     = 443
      protocol = "TCP"
    }

    ports {
      port     = 53
      protocol = "UDP"
    }

    ports {
      port     = 853
      protocol = "TCP"
    }

    environment_variables = {
      TZ                             = var.timezone
      FTLCONF_webserver_api_password = var.password
    }

    volume {
      mount_path           = "/etc/pihole"
      name                 = "filestorage"
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.share.name
    }
  }
}
