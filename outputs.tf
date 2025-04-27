output "ipv4_address" {
  description = "The public IPv4 address attached to the server."
  value       = var.enable_ipv4 ? hcloud_primary_ip.ipv4[0].ip_address : null
  sensitive   = true
}

output "ipv6_address" {
  description = "The public IPv6 address attached to the server."
  value       = var.enable_ipv6 ? hcloud_primary_ip.ipv6[0].ip_address : null
  sensitive   = true
}
