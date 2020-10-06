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
  description     = "The name of the Func App"

  validation {
    condition     = length(var.name) > 4
    error_message = "The length of name must be greater than 4."
  }
}

variable "kind" {
  type            = string
  default         = "windows"
  description     = "Determine the kind of the App Service Plan"

  validation {
    condition     = contains(["windows", "linux", "elastic", "functionapp"], var.kind)
    error_message = "Argument \"kind\" must be either \"windows\", \"linux\", \"elastic\" or \"functionapp\"."
  }
}

variable "tier" {
  type            = string
  default         = "Free"
  description     = "Determine the tier of the App Service Plan"

  validation {
    condition     = contains(["Free", "Shared", "Dynamic", "Basic", "Standard", "Premium", "Isolated"], var.tier)
    error_message = "Argument \"tier\" must be either \"Free\", \"Shared\", \"Basic\", \"Standard\", \"Premium\" or \"Isolated\"."
  }
}

variable "size" {
  type            = string
  default         = "F1"
  description     = "Determine the replication type of the Storage Account"

  validation {
    condition     = contains(["F1", "D1", "Y1", "B1", "B2", "B3", "D1", "P1V2", "P2V2", "P3V2", "PC2", "PC3", "PC4", "I1", "I2", "I3"], var.size)
    error_message = "Argument \"size\" must be either \"F1\", \"D1\", \"Y1\", \"B1\", \"B2\", \"B3\", \"D1\", \"P1V2\", \"P2V2\", \"P3V2\", \"PC2\", \"PC3\", \"PC4\", \"I1\", \"I2\" or \"I3\"."
  }
}