resource "azurerm_container_group" "wordpress" {
  name                = "wordpress-container"
  location            = azurerm_resource_group.wordpress.location
  resource_group_name = azurerm_resource_group.wordpress.name
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "wordpress"
    image  = var.wordpress_image
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      WORDPRESS_DB_HOST     = azurerm_mysql_server.wordpress_db.fqdn
      WORDPRESS_DB_USER     = var.db_user
      WORDPRESS_DB_PASSWORD = var.db_password
      WORDPRESS_DB_NAME     = var.db_name
    }
  }
}
