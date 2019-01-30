#! /usr/bin/env ruby
# frozen_string_literal: true

#
#   check-raid
#
# DESCRIPTION:
#   Checks the status of all virtual drives of a particular controller
#
#   MegaCli/MegaCli64 requires root access
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
#   Copyright 2014 Magnus Hagdorn <magnus.hagdorn@ed.ac.uk>
#   The University of Edinburgh
#   Released under the same terms as Sensu (the MIT license); see LICENSE  for details.
#

require 'sensu-plugin/check/cli'
require 'English'

#
# Check MegaRAID
#
class CheckMegaRAID < Sensu::Plugin::Check::CLI
  option :megaraidcmd,
         description: 'the MegaCli executable',
         short: '-c CMD',
         long: '--command CMD',
         default: '/opt/MegaRAID/MegaCli/MegaCli64'

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
    # get list of virtual drives
    stdout = `#{config[:megaraidcmd]} -LDInfo -LALL -a#{config[:controller]} `.split("\n")
    virtual_drives = []
    stdout.each do |line|
      if line =~ /^Virtual Drive:/
        virtual_drives << line.gsub(/^Virtual Drive: (\d+) .*$/, '\1')
      end
    end
    virtual_drives.each do |i|
      # and check them in turn
      stdout = `#{config[:megaraidcmd]} -LDInfo -L#{i} -a#{config[:controller]} `
      unless Regexp.new(/State\s+:\s+Optimal/).match(stdout)
        error = sprintf '%svirtual drive %d: %s ', error, i, stdout[/State\s*:\s*.*/].split(':')[1] # rubocop:disable Style/FormatString
        have_error = true
      end
    end

    if have_error
      critical error
    else
      ok
    end
  end
end
