resource "azurerm_storage_account" "storage" {
  name                     = "${var.common_name}storage${random_id.rand.hex}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
}


resource "azurerm_storage_share" "adguard" {
  name                 = "${var.common_name}adguard"
  storage_account_name = azurerm_storage_account.storage.name
  # storage_account_id   = azurerm_storage_account.storage.id
  quota = 1 //GB
}

resource "azurerm_storage_share_file" "AdGuardHome" {
  name             = "AdGuardHome.yaml"
  storage_share_id = azurerm_storage_share.adguard.id
  source           = "${path.root}/config/adguard/AdGuardHome.yaml"
  content_md5      = filemd5("${path.root}/config/adguard/AdGuardHome.yaml")
}

resource "azurerm_storage_share_file" "certificate" {
  name             = "certificate.pem"
  storage_share_id = azurerm_storage_share.adguard.id
  source           = var.cert_path
  content_md5      = filemd5(var.cert_path)
}

# locals {
#   cert_md5 = try(filemd5(var.cert_path), "")
#   key_md5  = try(filemd5(var.key_path), "")
# }

resource "azurerm_storage_share_file" "private_key" {
  name             = "private_key.pem"
  storage_share_id = azurerm_storage_share.adguard.id
  source           = var.key_path
  content_md5      = filemd5(var.key_path)
}


resource "azurerm_storage_share" "unbound" {
  name                 = "${var.common_name}unbound"
  storage_account_name = azurerm_storage_account.storage.name
  # storage_account_id = azurerm_storage_account.storage.id
  quota = 1 //GB
}

resource "azurerm_storage_share_file" "a-records" {
  name             = "a-records.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/a-records.conf"
  content_md5      = filemd5("${path.root}/config/unbound/a-records.conf")
}

resource "azurerm_storage_share_file" "forward-records" {
  name             = "forward-records.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/forward-records.conf"
  content_md5      = filemd5("${path.root}/config/unbound/forward-records.conf")
}

resource "azurerm_storage_share_file" "hints" {
  name             = "root.hints"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/root.hints"
  content_md5      = filemd5("${path.root}/config/unbound/root.hints")
}

resource "azurerm_storage_share_file" "srv-records" {
  name             = "srv-records.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/srv-records.conf"
  content_md5      = filemd5("${path.root}/config/unbound/srv-records.conf")
}

resource "azurerm_storage_share_file" "conf" {
  name             = "unbound.conf"
  storage_share_id = azurerm_storage_share.unbound.id
  source           = "${path.root}/config/unbound/unbound.conf"
  content_md5      = filemd5("${path.root}/config//unbound/unbound.conf")
}
