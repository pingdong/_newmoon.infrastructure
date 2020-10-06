variable "service" {
  type            = string
  description     = "The name of the service"

  validation {
    condition     = length(var.service) > 4
    error_message = "The length of service must be greater than 4."
  }
}

variable "environment" {
  type            = string
  description     = "The environment of resources"

  validation {
    condition     = length(var.environment) > 1
    error_message = "The length of environment must be greater than 1."
  }
}

variable "suffix" {
  type            = string
  description     = "The suffix of the name of resources"
  default         = ""
}

variable "tags" {
  type            = map
  description     = "The tags for the resources"
  default         = {}
}

variable "location" {
  type            = string
  description     = "The lcoation of resources"

  validation {
    condition     = length(var.location) > 4
    error_message = "The length of location must be greater than 4."
  }
}

variable "target" {
  type            = string
  description     = "The lcoation of resources"
  default         = "general"

  validation {
    condition     = contains(["general", "integration_test-shared", "integration_test"], var.target)
    error_message = "Argument \"sku\" must be either \"general\", \"integration_test-shared\" or \"integration_test\"."
  }
}

# Local Development Support
variable "local_development" {
  type            = bool
  description     = "Is local development"
  default         = false
}

# Integration Testing Support
variable "integration_testing" {
  type            = object({
                      features  = list(string)
                      suffix    = string
                    })
  description     = "The parameters of the integration testing"
  default         = {
                      features  = []
                      suffix    = ""
                    }
}
