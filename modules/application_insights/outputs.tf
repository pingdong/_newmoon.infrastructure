output "instrumentation_key" {
  value     = azurerm_application_insights.current.instrumentation_key
  sensitive = true
}