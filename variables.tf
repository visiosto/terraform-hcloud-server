variable "allow_http" {
  description = "Allow incoming HTTP traffic."
  type        = bool
  default     = false
}

variable "allow_https" {
  description = "Allow incoming HTTPS traffic."
  type        = bool
  default     = true
}

variable "allow_https_from_cloudflare" {
  description = "Allow incoming HTTPS traffic from Cloudflare IP addresses."
  type        = bool
  default     = false
}

variable "allow_icmp" {
  description = "Allow incoming ICMP traffic."
  type        = bool
  default     = true
}

variable "allow_ssh" {
  description = "Allow incoming SSH traffic."
  type        = bool
  default     = false
}

variable "datacenter" {
  description = "The location of the server."
  type        = string
}

variable "enable_backups" {
  description = "Whether to enable backups for the server."
  type        = bool
  default     = false
}

variable "enable_ipv4" {
  description = "Whether to create and attach a public IPv4 to the server."
  type        = bool
  default     = true
}

variable "enable_ipv6" {
  description = "Whether to create and attach a public IPv6 to the server."
  type        = bool
  default     = true
}

variable "firewall_rules" {
  description = "Custom firewall rules for the server firewall. If the direction is omitted, ingress (`in`) is used by default. If the protocol is omitted, TCP is used by default. The most common rules can also be applied by using the `allow_*` input variables."
  type = list(object({
    direction       = optional(string)
    protocol        = optional(string)
    port            = optional(string)
    source_ips      = optional(list(string))
    destination_ips = optional(list(string))
  }))
  default = []
}

variable "image" {
  description = "The OS image to create the server with."
  type        = string
}

variable "keep_disk" {
  description = "Whether to keep the size of the disk the same when upgrading the server type. If true, the server can be downgraded later."
  type        = bool
  default     = true
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
