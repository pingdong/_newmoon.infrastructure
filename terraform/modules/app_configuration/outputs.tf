output "name" {
  value     = azurerm_app_configuration.current.name
}

output "connection_string" {
  value     = azurerm_app_configuration.current.primary_read_key.0.connection_string
  sensitive = true
}