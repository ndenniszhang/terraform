output "container_ip" {
  value = azurerm_container_group.aci.ip_address
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "file_share_name" {
  value = azurerm_storage_share.share.name
}
