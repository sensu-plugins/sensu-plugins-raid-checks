#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
### Added
- add option to check-3ware-status to specify the path to tw-cli binary

## [0.1.1] - 2016-09-01
### Added
- improvement to regex checks for check_software method in check-raid plugin

## [0.1.1] - 2016-08-17
### Fixed
- Fixed typo in check-megaraid-sas-status.rb

### Changed
- Added -s/--sudo flag to allow check-megaraid-sas-status.rb to run with sudo

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

[unreleased]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.1.1...HEAD
[0.1.1]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.4...0.1.0
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.1...0.0.2
