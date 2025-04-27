output "ipv4_address" {
  description = "The public IPv4 address attached to the server."
  value       = hcloud_primary_ip.ipv4[0].ip_address
  sensitive   = true
}

output "ipv6_address" {
  description = "The public IPv6 address attached to the server."
  value       = hcloud_primary_ip.ipv6[0].ip_address
  sensitive   = true
}
