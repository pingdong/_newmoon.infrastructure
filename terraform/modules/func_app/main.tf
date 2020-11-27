data "azurerm_resource_group" "current" {
  name                        = var.resource_group
}

data "azurerm_storage_account" "current" {
  name                        = var.storage_account
  resource_group_name         = var.resource_group
}

data "azurerm_app_service_plan" "current" {
  name                        = var.app_service_plan
  resource_group_name         = var.resource_group
}

# Func App
resource "azurerm_function_app" "current" {
  name                        = var.name
  location                    = data.azurerm_resource_group.current.location
  resource_group_name         = data.azurerm_resource_group.current.name
  tags                        = var.tags

  app_service_plan_id         = data.azurerm_app_service_plan.current.id
  storage_account_name        = data.azurerm_storage_account.current.name
  storage_account_access_key  = data.azurerm_storage_account.current.primary_access_key
  version                     = var.runtime_version
           
  app_settings                = var.app_settings 
  
  # Creating multiple Connection_String blocks
  # When the Function App requires multiple connections, Azure SQL, Cosmos Db, etc
  # Connection_String block is not assignable
  dynamic "connection_string"   {
                                  iterator = connection
                                  for_each = var.connection_strings

                                  content {
                                    name  = connection.value["name"]
                                    type  = connection.value["type"]
                                    value = connection.value["value"]
                                  }
                                } 
}

# Creating slot(s) based on the input variable
resource "azurerm_function_app_slot" "current" {
  count                      = length(var.slots)

  function_app_name          = azurerm_function_app.current.name
  
  name                       = "${var.slots[count.index]}"
  location                   = data.azurerm_resource_group.current.location
  resource_group_name        = data.azurerm_resource_group.current.name
  
  app_service_plan_id        = data.azurerm_app_service_plan.current.id
  storage_account_name       = data.azurerm_storage_account.current.name
  storage_account_access_key = data.azurerm_storage_account.current.primary_access_key
}
