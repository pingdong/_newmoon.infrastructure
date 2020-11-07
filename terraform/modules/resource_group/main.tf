resource "azurerm_resource_group" "current" {
  name          = var.name
  location      = var.location
  tags          = var.tags
}