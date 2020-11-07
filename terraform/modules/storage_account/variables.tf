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

variable "tier" {
  type            = string
  default         = "Standard"
  description     = "Determine the tier of the Storage Account"

  validation {
    condition     = contains(["Standard", "Premium"], var.tier)
    error_message = "Argument \"tier\" must be either \"Standard\" or \"Premium\"."
  }
}

variable "access_tier" {
  type            = string
  default         = "Hot"
  description     = "Determine the tier of the Storage Account"

  validation {
    condition     = contains(["Cold", "Hot"], var.access_tier)
    error_message = "Argument \"access tier\" must be either \"Cold\" or \"Hot\"."
  }
}

variable "replication" {
  type            = string
  default         = "LRS"
  description     = "Determine the replication type of the Storage Account"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.replication)
    error_message = "Argument \"replication\" must be either \"LRS\", \"GRS\", \"RAGRS\", \"ZRS\", \"GZRS\" or \"RAGZRS\"."
  }
}

variable "kind" {
  type            = string
  default         = "StorageV2"
  description     = "Determine the kind of the Storage Account"

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.kind)
    error_message = "Argument \"replication\" must be either \"BlobStorage\", \"BlockBlobStorage\", \"FileStorage\", \"Storage\" or \"StorageV2\"."
  }
}