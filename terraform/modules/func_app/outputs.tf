output "name" {
  value = azurerm_function_app.current.name
}

output "slot_name" {
  value = azurerm_function_app_slot.current[0].name
}