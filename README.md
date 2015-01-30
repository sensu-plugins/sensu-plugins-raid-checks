## Sensu-Plugins-raid

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-raid.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-raid)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-raid.svg)](http://badge.fury.io/rb/sensu-plugins-raid)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-raid/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-raid)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-raid/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-raid)

## Functionality

* bin/check-3ware-status.rb
* bin/check-megaraid-sas-status.rb
* bin/check-raid
* bin/check-smart-array-status.rb

## Files

#### check-3ware-status.rb

#### check-megaraid-sas-status.rb

#### check-raid

#### check-smart-array-status.rb

## Installation


Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install <gem> -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

`gem install sensu-plugins-raid`

Add *sensu-plugins-raid* to your Gemfile, manifest, cookbook, etc

## Notes
