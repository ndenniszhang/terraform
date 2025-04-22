resource "azurerm_storage_account" "storage" {
  name                     = "${var.service_name}storage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
}

resource "azurerm_storage_share" "adguard" {
  name               = "${var.service_name}adguard"
  storage_account_id = azurerm_storage_account.storage.id
  quota              = 1 //GB
}

resource "azurerm_storage_share" "unbound" {
  name               = "${var.service_name}unbound"
  storage_account_id = azurerm_storage_account.storage.id
  quota              = 1 //GB
}
