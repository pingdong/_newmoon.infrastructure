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
  description     = "The tags for the resources"
  default         = {}
}

variable "name" {
  type            = string
  description     = "The name of the Func App"

  validation {
    condition     = length(var.name) > 4
    error_message = "The length of name must be greater than 4."
  }
}

variable "storage_account" {
  type            = string
  description     = "The name of the Storage Account"

  validation {
    condition     = length(var.storage_account) > 4
    error_message = "The length of name must be great than 4."
  }
}

variable "app_service_plan" {
  type            = string
  description     = "The name of the App Service Plan"

  validation {
    condition     = length(var.app_service_plan) > 4
    error_message = "The length of name must be great than 4."
  }
}

variable "runtime_version" {
  type            = string
  description     = "The runtime version of Function App"
  default         = "~3"

  validation {
    condition     = contains(["~1", "~2", "~3"], var.runtime_version)
    error_message = "Argument \"runtime_version\" must be either \"~1\", \"~2\" or \"~3\"."
  }
}

variable "app_settings" {
  type            = map
  description     = "The settings of the Func App"
  default         = {}
}

variable "connection_strings" {
  type            = list(object({
                        name  = string
                        type  = string
                        value = string           
                      }))
  description     = "The connection strings"
  default         = []
}

variable "slots" {
  type            = list(string)
  description     = "The name of slots"
  default         = []
}