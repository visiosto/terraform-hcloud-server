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

# TODO: Maybe support adding user-data (cloud-init).
resource "hcloud_server" "this" {
  name        = local.resource_name
  server_type = var.server_type
  image       = var.image
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.this]
  keep_disk   = var.keep_disk
}
