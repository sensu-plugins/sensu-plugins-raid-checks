#! /usr/bin/env ruby
#
#   check-raid
#
# DESCRIPTION:
#   Checks the status of all virtual drives of a particular controller
#
# sas2ircu requires root access
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: english
#
# USAGE:
#
# NOTES:
#
# LICENSE:
#   Copyright 2015 Magnus Hagdorn <magnus.hagdorn@ed.ac.uk>
#   The University of Edinburgh
#   Released under the same terms as Sensu (the MIT license); see LICENSE  for details.
#

require 'sensu-plugin/check/cli'
require 'English'

#
# Check MegaRAID
#
class CheckMPT2SAS < Sensu::Plugin::Check::CLI
  option :sas2ircucmd,
         description: 'the sas2ircu executable',
         short: '-c CMD',
         long: '--command CMD',
         default: '/usr/sbin/sas2ircu'
  option :controller,
         description: 'the controller to query',
         short: '-C ID',
         long: '--controller ID',
         proc: proc(&:to_i),
         default: 0
  # Main function
  #
  def run
    have_error = false
    error = ''
    volume_state = /\s*Volume\ state\s*:\s*(?<VolState>.*)/x

    stdout = `#{config[:sas2ircucmd]} #{config[:controller]} status `
    stdout.each_line do |line|
      parts = line.match(volume_state)
      unless parts.nil?
        unless parts['VolState'] == 'Optimal'
          error = '%s%s ' % [error, parts['VolState']]
          have_error = true
        end
      end
    end

    if have_error
      critical error
    else
      ok
    end
  end
end
