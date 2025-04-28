resource "azurerm_storage_account" "storage" {
  name                     = "${var.service_name}storage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
}


resource "azurerm_storage_share" "adguard" {
  name                 = "${var.service_name}adguard"
  storage_account_name = azurerm_storage_account.storage.name
  # storage_account_id   = azurerm_storage_account.storage.id
  quota = 1 //GB
}

resource "azurerm_storage_share_file" "AdGuardHome" {
  name             = "AdGuardHome.yaml"
  storage_share_id = azurerm_storage_share.adguard.id
  source           = "${path.root}/config/adguard/AdGuardHome.yaml"
}

resource "azurerm_storage_share_file" "certificate" {
  name             = "certificate.pem"
  storage_share_id = azurerm_storage_share.adguard.id
  source           = "${path.root}/config/cert/certificate.pem"
}

resource "azurerm_storage_share_file" "private_key" {
  name             = "private_key.pem"
  storage_share_id = azurerm_storage_share.adguard.id
  source           = "${path.root}/config/cert/private_key.pem"
}


resource "azurerm_storage_share" "unbound" {
  name                 = "${var.service_name}unbound"
  storage_account_name = azurerm_storage_account.storage.name
  # storage_account_id = azurerm_storage_account.storage.id
  quota = 1 //GB
}

resource "azurerm_storage_share_file" "a-records" {
  name             = "a-records.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/a-records.conf"
}

resource "azurerm_storage_share_file" "forward-records" {
  name             = "forward-records.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/forward-records.conf"
}

resource "azurerm_storage_share_file" "hints" {
  name             = "root.hints"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/root.hints"
}

resource "azurerm_storage_share_file" "srv-records" {
  name             = "srv-records.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/srv-records.conf"
}

resource "azurerm_storage_share_file" "conf" {
  name             = "unbound.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/unbound.conf"
}
