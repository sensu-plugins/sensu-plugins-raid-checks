# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md).
Which is based on [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
- Add sensu bonsai asset build
- Bump bundler version to 2.1

## [2.0.3] - 2019-02-17
### Fixed
- `check-megaraid-sas-status.rb`: Fixed logic error in which it was assumed that all virtual drives were in sequential order. Also fixed pattern matching when parsing individual drive status. (@SeanSith)

## [2.0.2] - 2018-04-18
### Fixed
- fixed software raid check (@corro)

## [2.0.1] - 2017-01-31
### Security
- updated rubocop dependency to `~> 0.51.0` per: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8418. (@majormoses)

### Changed
- appeased the cops (@majormoses)

## [2.0.0] - 2017-12-28
### Breaking Change
- `check-raid.rb`: added option `--log` with a default of `false` to prevent it default creating a log which is frequently being written to and filling up the disk. This does the *opposite* of what the vendor defaults are but due to the nature of those running it through a monitoring solution like sensu the defaults do not make sense in this use case. If you are wanting those logs you can change this to `true` to keep existing behavior. (@dhpowrhost) (@smbambling)

### Changed
- changelog guidelines location (@majormoses)

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

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/2.0.3...HEAD
[2.0.3]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/2.0.2...2.0.3
[2.0.2]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/2.0.1...2.0.2
[2.0.1]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/1.0.0...2.0.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.1.0...1.0.0
[0.1.0]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.4...0.1.0
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-raid-checks/compare/0.0.1...0.0.2
