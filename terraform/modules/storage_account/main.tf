data "azurerm_resource_group" "current" {
  name                        = var.resource_group
}

# Storage Account
resource "azurerm_storage_account" "current" {
  name                      = var.name
  location                  = data.azurerm_resource_group.current.location
  resource_group_name       = data.azurerm_resource_group.current.name
  tags                      = var.tags

  account_kind              = var.kind
  account_tier              = var.tier
  account_replication_type  = var.replication
}