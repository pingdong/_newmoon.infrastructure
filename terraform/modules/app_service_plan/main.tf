data "azurerm_resource_group" "current" {
  name                        = var.resource_group
}

# App Service Plan
resource "azurerm_app_service_plan" "current" {
  name                  = var.name
  location              = data.azurerm_resource_group.current.location
  resource_group_name   = data.azurerm_resource_group.current.name
  tags                  = var.tags

  kind                  = var.kind
  sku {
    tier                = var.tier
    size                = var.size
  }
}