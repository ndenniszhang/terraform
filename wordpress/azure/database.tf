resource "azurerm_mysql_server" "wordpress_db" {
  name                = "wordpress-mysql-server"
  location            = azurerm_resource_group.wordpress.location
  resource_group_name = azurerm_resource_group.wordpress.name

  administrator_login          = var.db_user
  administrator_login_password = var.db_password

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
}

resource "azurerm_mysql_database" "wordpress_db" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_server.wordpress_db.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
