variable "resource_group" {
  type            = string
  description     = "The name of the containing Resources Group"

  validation {
    condition     = length(var.resource_group) > 0
    error_message = "The length of resource_group must be not empty."
  }
}

variable "tags" {
  type            = map
  default         = {}
  description     = "The tags for the resources"
}

variable "name" {
  type            = string
  description     = "The name of the KeyVault"
  default         = "kv"

  validation {
    condition     = length(var.name) > 1
    error_message = "The length of name must be great than 1."
  }
}

variable "sku" {
  type            = string
  default         = "standard"
  description     = "Determine the sku of the KeyVault"

  validation {
    condition     = contains(["standard", "premium"], var.sku)
    error_message = "Argument \"sku\" must be either \"standard\" or \"premium\"."
  }
}

variable "default_acl_action" {
  type            = string
  description     = "The default network acl"
  default         = "Deny"

  validation {
    condition     = contains(["Deny", "Allow"], var.default_acl_action)
    error_message = "Argument \"sku\" must be either \"Allow\" or \"Deny\"."
  }
}

variable "ip_rules" {
  type            = list(string)
  description     = "The allowed IPs"
  default         = []
}

variable "bypass_azure_services" {
  type            = bool
  description     = "Should bypass Azure Services or not"
}

