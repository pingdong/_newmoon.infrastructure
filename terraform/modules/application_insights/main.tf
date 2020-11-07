data "azurerm_resource_group" "current" {
  name                        = var.resource_group
}

# Application Insight
resource "azurerm_application_insights" "current" {
  name                  = var.name
  location              = data.azurerm_resource_group.current.location
  resource_group_name   = data.azurerm_resource_group.current.name
  tags                  = var.tags

  application_type      = var.application_type
}