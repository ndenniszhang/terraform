resource "azurerm_storage_account_network_rules" "firewall_rules" {
  storage_account_id         = azurerm_storage_account.storage.id
  default_action             = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.aci_subnet.id]
  bypass                     = ["AzureServices"]
  # ip_rules                   = []
}
