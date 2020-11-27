# More information on the authentication methods supported by
# the AzureRM Provider can be found here:
# http://terraform.io/docs/providers/azurerm/index.html

terraform {
  required_version  = ">=0.13.5"

  required_providers {
    azurerm         = {
      source        = "hashicorp/azurerm"
      version       = ">= 2.36.0"
    }
  }

  backend "azurerm" {
  }
}

provider "azurerm" {
  features {
    key_vault {
      # For local develpment and debugging convenice
      purge_soft_delete_on_destroy = var.local_development
    }
  }
}

locals {
  # Tags Chain to make sure of adding common tags to all resources
  tags              = merge(
                        map(
                          "service", var.service, 
                          "environment", var.environment
                        ),
                        var.tags
                      )
  
  # The reason of using <> as placeholder is <> is invalid for most resources. It avoids unintent errors.
  suffix            = substr(uuid(), 0, 6)
  name-suffix       = "${var.service}-${var.environment}-<name>%{ if var.target == "integration_testing" }-${local.suffix}%{ endif }"
  name              = "${var.service}-${var.environment}-<name>"
  
  # Resource Groups
  rg-compute        = "${var.service}-${var.environment}-compute"
  rg-data           = "${var.service}-${var.environment}-data"
  rg-it             = "${var.service}-${var.environment}-${local.suffix}"
  rg-it-shared      = "${var.service}-${var.environment}"

  # Configuration Keys
  kv-secret-ac              = "AppConfiguration-ConnectionString"
  connection_string-ac      = "AppConfiguration"

  # Target
  target                    = {
    general                 = "general"
    integration_test-shared = "integration_test-shared"
    integration_test        = "integration_test"
  }
  environment               = {
    development             = "dev"
    production              = "prod"
  }
  # Functions
  #    Providing variables of all func apps here to create multiple func apps easily
  functionApps      = list(
                        {
                          name          = "venue"
                          app_settings  = {}
                          slots         = ["stage"]
                        }
                      )
  #   Building keys list for filtering out func apps that do(es)n't include in the current testing
  functionAppKeys   = [for fa in local.functionApps : fa.name]
  functions         = var.target == local.target.general ? local.functionApps : matchkeys(local.functionApps, local.functionAppKeys, var.integration_testing-features)
}

# Resource Group
#   Integration Testing Shared
module "rg-integration_test-shared" {
  source              = "./modules/resource_group"
  count               = var.target == local.target.integration_test-shared ? 1 : 0

  name                = local.rg-it-shared
  tags                = local.tags
  location            = var.location
}
module "rg-integration_test" {
  source              = "./modules/resource_group"
  count               = var.target == local.target.integration_test ? 1 : 0

  name                = local.rg-it
  tags                = local.tags
  location            = var.location
}
#   SIT / QA / UAT / PROD
module "rg-compute" {
  source              = "./modules/resource_group"
  count               = var.target == local.target.general ? 1 : 0

  name                = local.rg-compute
  tags                = local.tags
  location            = var.location
}
module "rg-data" {
  source              = "./modules/resource_group"
  count               = var.target == local.target.general ? 1 : 0

  name                = local.rg-data
  tags                = local.tags  
  location            = var.location
}

# Key Vault
module "key_vault" {
  source                = "./modules/key_vault"
  count                 = var.target == local.target.general ? 1 : 0

  resource_group        = module.rg-data[0].name
  name                  = replace(local.name, "<name>", "kv")
  tags                  = local.tags
  
  sku                   = "standard"
                        # Relax restriction for development
  default_acl_action    = "Allow"
  # default_acl_action    = var.local_development ? "Allow" : "Deny"
  # bypass_azure_services = true
  # ip_rules              = [
  #                         "20.37.158.0/23",
  #                         "20.37.194.0/24",
  #                         "20.39.13.0/26",
  #                         "20.41.6.0/23",
  #                         "20.41.194.0/24",
  #                         "20.42.5.0/24",
  #                         "20.42.134.0/23",
  #                         "20.42.226.0/24",
  #                         "20.45.196.64/26",
  #                         "20.189.107.0/24",
  #                         "40.74.28.0/23",
  #                         "40.80.187.0/24",
  #                         "40.82.252.0/24",
  #                         "40.119.10.0/24",
  #                         "51.104.26.0/24",
  #                         "52.150.138.0/24",
  #                         "52.228.82.0/24",
  #                         "191.235.226.0/24"
  #                       ]  

  depends_on            = [
                          module.rg-compute
                        ]
}

# App Configuration
module "app_configuration" {
  source              = "./modules/app_configuration"
  count               = var.target == local.target.integration_test ? 0 : 1

  resource_group      = var.target == local.target.general ? module.rg-data[0].name : module.rg-integration_test-shared[0].name
  name                = replace(local.name, "<name>", "ac")
  tags                = local.tags

  sku                 = "standard"

  depends_on          = [
                          module.rg-compute,
                          module.rg-integration_test-shared
                        ]
}
resource "azurerm_key_vault_secret" "app_configuration" {
  count               = var.target == local.target.general ? 1 : 0

  key_vault_id        = module.key_vault[0].id
  name                = local.kv-secret-ac
  value               = module.app_configuration[0].connection_string

  depends_on          = [
                          module.key_vault,
                          module.app_configuration
                        ]
}
data "azurerm_app_configuration" "integration_test" {
  count               = var.target == local.target.integration_test ? 1 : 0

  name                = replace(local.name, "<name>", "ac")
  resource_group_name = local.rg-it-shared
}

# Application Insight
module "application_insights" {
  source              = "./modules/application_insights"
  count               = var.target == local.target.integration_test ? 0 : 1

  resource_group      = var.target == local.target.general ? module.rg-data[0].name : module.rg-integration_test-shared[0].name
  name                = replace(local.name, "<name>", "ai")
  tags                = local.tags

  application_type    = "web"

  depends_on          = [
                          module.rg-compute,
                          module.rg-integration_test-shared
                        ]
}
data "azurerm_application_insights" "integration_test" {
  count               = var.target == local.target.integration_test ? 1 : 0

  name                = replace(local.name, "<name>", "ai")
  resource_group_name = local.rg-it-shared
}

# Func Apps
module "asp-func_serverless" {
  source              = "./modules/app_service_plan"
  count               = var.target == local.target.integration_test-shared || length(local.functions) == 0 ? 0 : 1

  resource_group      = var.target == local.target.general ? module.rg-compute[0].name : module.rg-integration_test[0].name
  name                = replace(local.name-suffix, "<name>", "asp-func")
  tags                = local.tags

  kind                = "functionapp"
  tier                = "Dynamic"
  size                = "Y1"

  depends_on          = [
                          module.rg-compute,
                          module.rg-integration_test.name
                        ]
}
module "storage_account-func" {
  source              = "./modules/storage_account"
  count               = var.target == local.target.integration_test-shared || length(local.functions) == 0 ? 0 : 1

  resource_group      = var.target == local.target.general ? module.rg-compute[0].name : module.rg-integration_test[0].name
  name                = lower( replace( replace(local.name-suffix, "<name>", "sa-func"), "-", "") )
  tags                = local.tags
  
  tier                = "Standard"

  depends_on          = [
                          module.rg-compute,
                          module.rg-integration_test.name
                        ]
}
module "func" {
  count                     = length(local.functions)
  
  source                    = "./modules/func_app"
  
  resource_group            = var.target == local.target.general ? module.rg-compute[0].name : module.rg-integration_test[0].name
  name                      = replace(local.name-suffix, "<name>", "func-${local.functions[count.index].name}")
  tags                      = local.tags

  # Shared resources for all function apps
  app_service_plan          = module.asp-func_serverless[0].name
  storage_account           = module.storage_account-func[0].name

  app_settings              = merge(
                                map(
                                  "APPINSIGHTS_INSTRUMENTATIONKEY", var.target == local.target.general ? module.application_insights[0].instrumentation_key : data.azurerm_application_insights.integration_test[0].instrumentation_key
                                ),
                                local.functions[count.index].app_settings
                              )
  connection_strings        = [{
                                name  = local.connection_string-ac 
                                type  = "Custom" 
                                # Keyvault is not required in the integration testing
                                value = var.target == local.target.general ? replace("@Microsoft.KeyVault(SecretUri=<id>)", "<id>", azurerm_key_vault_secret.app_configuration[0].id) : data.azurerm_app_configuration.integration_test[0].primary_read_key.0.connection_string
                              }]
  slots                     = var.environment == local.environment.production ? local.functions[count.index].slots : []

  depends_on                = [
                                module.rg-compute,
                                module.asp-func_serverless,
                                module.storage_account-func,
                                module.application_insights
                              ]
}
