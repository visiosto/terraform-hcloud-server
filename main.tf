resource "random_uuid" "this" {
  count = var.name != null ? 1 : 0
}

locals {
  resource_name = var.name != null ? "${var.name_prefix}-${replace(random_uuid.this[0].result, "-", "")}" : var.name
}

# TODO: Should the module support adding multiple keys or omitting the key?
resource "hcloud_ssh_key" "this" {
  name       = local.resource_name
  public_key = var.public_key
}

resource "hcloud_primary_ip" "ipv4" {
  count = var.enable_ipv4 ? 1 : 0

  type          = "ipv4"
  name          = "ipv4-${local.resource_name}"
  datacenter    = var.datacenter
  auto_delete   = false
  assignee_type = "server"
}

resource "hcloud_primary_ip" "ipv6" {
  count = var.enable_ipv6 ? 1 : 0

  type          = "ipv6"
  name          = "ipv6-${local.resource_name}"
  datacenter    = var.datacenter
  auto_delete   = false
  assignee_type = "server"
}

data "cloudflare_ip_ranges" "current" {
}

locals {
  firewall_rule_cloudflare_https = {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = concat(
      var.enable_ipv4 ? data.cloudflare_ip_ranges.current.ipv4_cidrs : [],
      var.enable_ipv6 ? data.cloudflare_ip_ranges.current.ipv6_cidrs : [],
    )
  }
  firewall_rule_http = {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = concat(
      var.enable_ipv4 ? ["0.0.0.0/0"] : [],
      var.enable_ipv6 ? ["::/0"] : [],
    )
  }
  firewall_rule_https = {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      var.enable_ipv4 ? ["0.0.0.0/0"] : [],
      var.enable_ipv6 ? ["::/0"] : [],
    ]
  }
  firewall_rule_icmp = {
    direction = "in"
    protocol  = "icmp"
    port      = null
    source_ips = concat(
      var.enable_ipv4 ? ["0.0.0.0/0"] : [],
      var.enable_ipv6 ? ["::/0"] : [],
    )
  }
  firewall_rule_ssh = {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = concat(
      var.enable_ipv4 ? ["0.0.0.0/0"] : [],
      var.enable_ipv6 ? ["::/0"] : [],
    )
  }
  firewall_rules = concat(
    var.allow_https_from_cloudflare ? [local.firewall_rule_cloudflare_https] : [],
    var.allow_http ? [local.firewall_rule_http] : [],
    var.allow_https ? [local.firewall_rule_https] : [],
    var.allow_icmp ? [local.firewall_rule_icmp] : [],
    var.allow_ssh ? [local.firewall_rule_ssh] : [],
    [
      for r in var.firewall_rules : {
        direction       = r.direction != null ? r.directotion : "in"
        protocol        = r.protocol != null ? r.protocol : "tcp"
        port            = r.port
        source_ips      = r.source_ips
        destination_ips = r.destination_ips
      }
    ]
  )
}

resource "hcloud_firewall" "this" {
  name = local.resource_name

  dynamic "rule" {
    for_each = local.firewall_rules

    content {
      direction  = rule.value.direction
      protocol   = rule.value.protocol
      port       = rule.value.port
      source_ips = rule.value.source_ips
    }
  }
}

locals {
  location = split(var.datacenter, "-")[0]
}

# TODO: Maybe support adding user-data (cloud-init).
resource "hcloud_server" "this" {
  name         = local.resource_name
  server_type  = var.server_type
  image        = var.image
  location     = local.location # TODO: Do we need the data center, too?
  ssh_keys     = [hcloud_ssh_key.this.id]
  keep_disk    = var.keep_disk
  backups      = var.enable_backups
  firewall_ids = [hcloud_firewall.this.id]

  public_net {
    ipv4_enabled = var.enable_ipv4
    ipv4         = var.enable_ipv4 ? hcloud_primary_ip.ipv4[0].id : null
    ipv6_enabled = var.enable_ipv6
    ipv6         = var.enable_ipv6 ? hcloud_primary_ip.ipv6[0].id : null
  }
}
