resource "random_uuid" "this" {
}

locals {
  resource_name = var.name != null ? "${var.name_prefix}-${replace(random_uuid.this.result, "-", "")}" : var.name
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

locals {
  location = split(var.datacenter, "-")[0]
}

# TODO: Maybe support adding user-data (cloud-init).
resource "hcloud_server" "this" {
  name        = local.resource_name
  server_type = var.server_type
  image       = var.image
  location    = local.location
  ssh_keys    = [hcloud_ssh_key.this]
  keep_disk   = var.keep_disk

  public_net {
    ipv4_enabled = var.enable_ipv4
    ipv4         = var.enable_ipv4 ? hcloud_primary_ip.ipv4[0].id : null
    ipv6_enabled = var.enable_ipv6
    ipv6         = var.enable_ipv6 ? hcloud_primary_ip.ipv6[0].id : null
  }
}
