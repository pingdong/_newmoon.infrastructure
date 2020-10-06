variable "location" {
  type            = string
  description     = "The lcoation of resources"

  validation {
    condition     = length(var.location) > 4
    error_message = "The length of location must be greater than 4."
  }
}

variable "tags" {
  type            = map
  default         = {}
  description     = "The tags for the resources"
}

variable "name" {
  type            = string
  default         = "compute"
  description     = "Determine the type of the Resource Group"

  validation {
    condition     = length(var.name) > 4
    error_message = "The length of name must be greater than 4."
  }
}