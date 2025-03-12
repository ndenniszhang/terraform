output "aci_public_ip" {
  value = azurerm_container_group.wordpress.ip_address
}
