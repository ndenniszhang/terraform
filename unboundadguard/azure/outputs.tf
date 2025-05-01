output "container_ip" {
  description = "The IP address of the container group"
  value       = azurerm_container_group.aci.ip_address
}

output "static_ip" {
  description = "The static IP address of the load balancer"
  value       = azurerm_public_ip.static_ip.ip_address
}
