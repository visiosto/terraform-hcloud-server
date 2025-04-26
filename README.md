# Hetzner Cloud Server Terraform Module

Terraform module for creating servers on Hetzner Cloud.

## Requirements

| Name                | Version   |
| ------------------- | --------- |
| terraform           | >= 1.9.0  |
| hetznercloud/hcloud | >= 1.50.0 |
| hashicorp/random    | >= 3.0.0  |

## Providers

| Name                | Version   |
| ------------------- | --------- |
| hetznercloud/hcloud | >= 1.50.0 |
| hashicorp/random    | >= 3.0.0  |

## Modules

No modules.

## Resources

| Name               | Type     |
| ------------------ | -------- |
| hcloud_server.this | resource |
| hcloud_ssh_key.ssh | resource |
| random_uuid.this   | resource |

## Inputs

| Name        | Description                                                                                                                                   | Type     | Default | Required |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ------- | :------: |
| datacenter  | The location of the server. See [Hetzner documentation](https://docs.hetzner.com/cloud/general/locations/) for the data centers and locations | `string` | `""`    |   yes    |
| image       | The OS image to create the server with                                                                                                        | `string` | `""`    |   yes    |
| keep_disk   | Whether to keep the size of the disk the same when upgrading the server type. If true, the server can be downgraded later                     | `bool`   | `true`  |    no    |
| name        | The name of the created server. If set, this overrides the default name that is created using the given prefix and a random ID                | `string` | `null`  |    no    |
| name_prefix | The prefix to use in the automatically generated server name.                                                                                 | `string` | `null`  |    no    |
| public_key  | The public SSH key to add to the server                                                                                                       | `string` | `""`    |   yes    |
| server_type | The type of the server to create                                                                                                              | `string` | `""`    |   yes    |
| public_key  | The public SSH key to add to the server                                                                                                       | `string` | `""`    |   yes    |

## Outputs

No outputs.
