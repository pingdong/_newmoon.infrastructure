output "name" {
  value     = azurerm_key_vault.current.name
}

output "id" {
  value     = azurerm_key_vault.current.id
  sensitive = true
}