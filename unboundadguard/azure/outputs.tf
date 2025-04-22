output "container_ip" {
  description = "The IP address of the container group"
  value       = azurerm_container_group.aci.ip_address
}

output "container_fqdn" {
  description = "The FQDN of the container group"
  value       = azurerm_container_group.aci.fqdn
}
