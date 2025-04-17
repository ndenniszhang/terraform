resource "azurerm_storage_account" "storage" {
  name                     = "${var.app_name}storage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share" {
  name               = "${var.app_name}share"
  storage_account_id = azurerm_storage_account.storage.name
  quota              = 4 //GB
}

resource "azurerm_storage_container" "blob" {
  name                  = "${var.app_name}blob"
  storage_account_id    = azurerm_storage_account.storage.name
  container_access_type = "private"
}
