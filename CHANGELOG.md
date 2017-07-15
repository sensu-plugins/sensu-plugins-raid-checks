#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
### Added
- Ruby 2.4.1 testing

### Removed
- Remove timeout gem dependency as this is not actually called in the code. However it was causing the build to fail. 

## [1.0.0] - 2017-02-02
### Added
- improvement to regex checks for check_software method in check-raid plugin (@scosist)
- Ruby 2.3.0 support (@mattyjones/@eheydrick)
- `check-3ware-status`: add option to specify the path to tw-cli binary (@GhostLyrics)

### Removed
- Ruby < 2.1 support (@mattyjones/@eheydrick)

## [0.1.0] - 2015-09-14
### Added
- added a new check-mpt2sas-status plugin

## [0.0.4] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

## [0.0.3] - 2015-06-04
### Added
- Merge PR #1
    - If a grep of lspci returns nothing then don't check for software raid.

### Fixed
- Set the gemspec to only create binstubs for Ruby scripts

## [0.0.2] - 2015-06-03
### Fixed
- added binstubs

### Changed
- removed cruft from /lib

## 0.0.1 - 2015-05-20
### Added
- initial release

[unreleased]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/1.0.0...HEAD
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.1.0...1.0.0
[0.1.0]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.4...0.1.0
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.1...0.0.2
