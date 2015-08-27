#! /usr/bin/env ruby
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
class CheckMegraRAID < Sensu::Plugin::Check::CLI
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
    # get number of virtual drives
    `#{config[:megaraidcmd]} -LDGetNum -a#{config[:controller]} `
    (0..$CHILD_STATUS.exitstatus - 1).each do |i|
      # and check them in turn
      stdout = `#{config[:megaraidcmd]} -LDInfo -L#{i} -a#{config[:controller]} `
      unless Regexp.new('State\s*:\s*Optimal').match(stdout)
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
