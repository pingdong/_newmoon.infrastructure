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
  description     = "The name of the App Configuration"
  default         = "ac"

  validation {
    condition     = length(var.name) > 1
    error_message = "The length of name must be great than 1."
  }
}

variable "sku" {
  type            = string
  default         = "free"
  description     = "Determine the sku of the AppConfiguration"

  validation {
    condition     = contains(["free", "standard"], var.sku)
    error_message = "Argument \"sku\" must be either \"free\" or \"standard\"."
  }
}