# Hetzner Cloud Server Terraform Module

Terraform module for creating servers on Hetzner Cloud.

## Requirements

| Name                  | Version   |
| --------------------- | --------- |
| terraform             | >= 1.9.0  |
| cloudflare/cloudflare | >= 5.0.0  |
| hetznercloud/hcloud   | >= 1.50.0 |
| hashicorp/random      | >= 3.0.0  |

## Providers

| Name                  | Version   |
| --------------------- | --------- |
| cloudflare/cloudflare | >= 5.0.0  |
| hetznercloud/hcloud   | >= 1.50.0 |
| hashicorp/random      | >= 3.0.0  |

## Modules

No modules.

## Resources

| Name                         | Type        |
| ---------------------------- | ----------- |
| cloudflare_ip_ranges.current | data source |
| hcloud_firewall.this         | resource    |
| hcloud_primary_ip.ipv4       | resource    |
| hcloud_primary_ip.ipv6       | resource    |
| hcloud_server.this           | resource    |
| hcloud_ssh_key.ssh           | resource    |
| random_uuid.this             | resource    |

## Inputs

| Name                        | Description                                                                                                                                                                                                                                                                                                               | Type     | Default | Required |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ------- | :------: |
| allow_http                  | Allow incoming HTTP traffic (ingress TCP traffic to port 80)                                                                                                                                                                                                                                                              | `bool`   | `false` |    no    |
| allow_https                 | Allow incoming HTTPS traffic (ingress TCP traffic to port 443)                                                                                                                                                                                                                                                            | `bool`   | `true`  |    no    |
| allow_https_from_cloudflare | Allow incoming HTTPS traffic from Cloudflare IP addresses (ingress TCP traffic to port 443)                                                                                                                                                                                                                               | `bool`   | `false` |    no    |
| allow_icmp                  | Allow incoming ICMP traffic                                                                                                                                                                                                                                                                                               | `bool`   | `true`  |    no    |
| allow_ssh                   | Allow incoming SSH traffic (ingress TCP traffic to port 22)                                                                                                                                                                                                                                                               | `bool`   | `false` |    no    |
| datacenter                  | The location of the server. See [Hetzner documentation](https://docs.hetzner.com/cloud/general/locations/) for the data centers and locations                                                                                                                                                                             | `string` | `""`    |   yes    |
| enable_backups              | Whether to enable backups for the server                                                                                                                                                                                                                                                                                  | `bool`   | `true`  |    no    |
| enable_ipv4                 | Whether to create and attach a public IPv4 to the server                                                                                                                                                                                                                                                                  | `bool`   | `true`  |    no    |
| enable_ipv6                 | Whether to create and attach a public IPv6 to the server                                                                                                                                                                                                                                                                  | `bool`   | `true`  |    no    |
| firewall_rules              | Custom firewall rules for the server firewall. If the direction is omitted, ingress (`in`) is used by default. If the protocol is omitted, TCP is used by default. The most common rules can also be applied by using the `allow_*` input variables. See the definition in [variables.tf](variables.tf) for the full type | `list`   | `[]`    |    no    |
| image                       | The OS image to create the server with                                                                                                                                                                                                                                                                                    | `string` | `""`    |   yes    |
| keep_disk                   | Whether to keep the size of the disk the same when upgrading the server type. If true, the server can be downgraded later                                                                                                                                                                                                 | `bool`   | `true`  |    no    |
| name                        | The name of the created server. If set, this overrides the default name that is created using the given prefix and a random ID. Either a `name` or `name_prefix` is required                                                                                                                                              | `string` | `null`  |    no    |
| name_prefix                 | The prefix to use in the automatically generated server name. Either a `name` or `name_prefix` is required                                                                                                                                                                                                                | `string` | `null`  |    no    |
| public_key                  | The public SSH key to add to the server                                                                                                                                                                                                                                                                                   | `string` | `""`    |   yes    |
| server_type                 | The type of the server to create                                                                                                                                                                                                                                                                                          | `string` | `""`    |   yes    |

## Outputs

No outputs.
