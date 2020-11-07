data "azurerm_resource_group" "current" {
  name                    = var.resource_group
}

# App Configuration
resource "azurerm_app_configuration" "current" {
  name                    = var.name
  location                = data.azurerm_resource_group.current.location
  resource_group_name     = data.azurerm_resource_group.current.name
  tags                    = var.tags

  sku                     = var.sku
}