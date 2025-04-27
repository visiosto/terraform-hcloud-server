# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2025-04-27

### Changed

- Use the data center to determine the location of the server instead of the
  calculated location.

### Fixed

- Flip the incorrect null checks for the `name` input variable to fix the UUID
  and the resource name.
- Fix the name of the iterator variable in the dynamic `rule` block in the
  firewall resource.
- Add the missing `port` to the ICMP firewall rule.
- Concatenate the source IP lists for the firewall rules correctly.

## [0.1.0] - 2025-04-27

- Initial release of the module for creating virtual servers for Hetzner Cloud.

[unreleased]:
  https://github.com/visiosto/terraform-hcloud-server/compare/v0.1.1...HEAD
[0.1.1]:
  https://github.com/visiosto/terraform-hcloud-server/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/visiosto/terraform-hcloud-server/releases/tag/v0.1.0
