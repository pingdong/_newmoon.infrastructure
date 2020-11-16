data "azurerm_resource_group" "current" {
  name                        = var.resource_group
}

data "azurerm_client_config" "current" {}

# Key Vault
resource "azurerm_key_vault" "current" {
  name                        = var.name
  location                    = data.azurerm_resource_group.current.location
  resource_group_name         = data.azurerm_resource_group.current.name
  tags                        = var.tags

  sku_name                    = var.sku
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  network_acls {    
    default_action            = var.default_acl_action    # Need relax some restrictions in local development
    bypass                    = var.bypass_azure_services ? "AzureServices" : "None"
    ip_rules                  = var.ip_rules
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "set",
      "get",
      "delete",
      "list"      # Terraform need to read secrets on the plan stage
    ]
  }
}