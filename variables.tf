variable "image" {
  description = "The OS image to create the server with."
  type        = string
}

variable "keep_disk" {
  description = "Whether to keep the size of the disk the same when upgrading the server type. If true, the server can be downgraded later."
  type        = bool
  default     = true
}

variable "location" {
  description = "The location of the server."
  type        = string
}

variable "name" {
  description = "The name of the created server. If set, this overrides the default name that is created using the given prefix and a random ID."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix to use in the automatically generated server name."
  type        = string
  default     = null

  validation {
    condition     = var.name != null || var.name_prefix != null
    error_message = "Either name or name_prefix must be set."
  }
}

variable "public_key" {
  description = "The public SSH key to add to the server."
  type        = string
}

variable "server_type" {
  description = "The type of the server to create."
  type        = string
}
