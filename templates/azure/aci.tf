
resource "azurerm_container_group" "aci" {
  name                = "${var.app_name}aci"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.id
  ip_address_type     = "Public"
  os_type             = "Linux"
  dns_name_label      = var.app_name

  container {
    name   = var.app_name
    image  = var.image_name
    cpu    = "1.0"
    memory = "1.0"

    environment_variables = {
      TZ = var.timezone
    }

    ports {
      port     = 80
      protocol = tcp
    }

    volume {
      name                 = "filestorage"
      mount_path           = var.mount_path
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name           = azurerm_storage_share.share.name
    }
  }
}
