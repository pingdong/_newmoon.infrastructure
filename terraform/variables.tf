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
  description     = "The suffix of the name of resources. The suffix is used to isolate different integration testing environments"
  default         = ""
}

variable "tags" {
  type            = map
  description     = "The common tags for the resources. The tags are added to all resources."
  default         = {}
}

variable "location" {
  type            = string
  description     = "The lcoation of resources deployment"

  validation {
    condition     = length(var.location) > 4
    error_message = "The length of location must be greater than 4."
  }
}

variable "target" {
  type            = string
  description     = "The target of deployment, available options: general, integration_test-shared, integration_test"
  default         = "general"

  validation {
    condition     = contains(["general", "integration_test-shared", "integration_test"], var.target)
    error_message = "Argument \"sku\" must be either \"general\", \"integration_test-shared\" or \"integration_test\"."
  }
}

# Local Development Support
variable "local_development" {
  type            = bool
  description     = "Whether current work is local development or not. When the value is true, a few network restriction and safe measures are lifted"
  default         = false
}

# Integration Testing Support
variable "integration_testing-features" {
  type            = list(string)
  description     = "The features of the integration testing"
  default         = []
}
