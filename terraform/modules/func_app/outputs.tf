output "name" {
  value = azurerm_function_app.current.name
}

# TODO: Return slot name list
output "slot_name" {
  value = length(var.slots) == 0 ? "" : azurerm_function_app_slot.current[0].name
}