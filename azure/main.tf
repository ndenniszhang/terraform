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
  name     = "parameters(resource_group_name)"
  location = "parameters(location)"
}

resource "azurerm_storage_account" "storage" {
  name                     = "acistorage+parameters(app_name)"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share" {
  name                 = "acishare"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 4
}


resource "azurerm_container_group" "aci" {
  name                = "aci-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "parameters(app_name)"
    image  = "parameters(image_name)"
    cpu    = "1.0"
    memory = "1.0"

    volume {
      name                 = "filestorage"
      mount_path           = "/etc/pihole"
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.share.name
    }
  }
}
