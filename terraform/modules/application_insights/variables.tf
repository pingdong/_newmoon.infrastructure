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
  description     = "The name of the Application Insight"
  default         = "ai"

  validation {
    condition     = length(var.name) > 1
    error_message = "The length of name must be great than 1."
  }
}

variable "application_type" {
  type            = string
  default         = "web"
  description     = "Determine the application type of the AppInsight"

  validation {
    condition     = contains(["ios", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "web"], var.application_type)
    error_message = "Argument \"app-type\" must be either \"ios\", \"java\", \"MobileCenter\", \"Node.JS\", \"phone\", \"store\", \"web\" or \"other\"."
  }
}