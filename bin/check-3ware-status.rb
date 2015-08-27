#! /usr/bin/env ruby
#
#   check-raid
#
# DESCRIPTION:
#   Check 3ware Status Plugin
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
#   Checks status for all HDDs in all 3ware controllers.
#
#   tw-cli requires root permissions.
#
#   Create a file named /etc/sudoers.d/tw-cli with this line inside :
#   sensu ALL=(ALL) NOPASSWD: /usr/sbin/tw-cli
#
# You can get Debian/Ubuntu tw-cli packages here - http://hwraid.le-vert.net/
#
# LICENSE:
#   Copyright 2014 Alexander Bulimov <lazywolf0@gmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE  for details.
#

require 'sensu-plugin/check/cli'
require 'open3'

#
# Check 3ware Status
#
class Check3wareStatus < Sensu::Plugin::Check::CLI
  # Setup variables
  #
  def initialize
    super
    @binary = 'sudo -n -k tw-cli'
    @controllers = []
    @good_disks = []
    @bad_disks = []
  end

  # Execute a specific command to acquire the exit code
  # stderr, and  raw data
  #
  # @param [String] command to run
  #
  def execute(cmd)
    captured_stdout = ''
    captured_stderr = ''
    exit_status = Open3.popen3(ENV, cmd) do |stdin, stdout, stderr, wait_thr|
      stdin.close
      captured_stdout = stdout.read
      captured_stderr = stderr.read
      wait_thr.value
    end
    [exit_status, captured_stdout, captured_stderr]
  end

  # Parse controller data
  #
  # @param data [String]
  #
  def parse_controllers!(data)
    data.lines.each do |line|
      unless line.empty?
        controller = line.split[0]
        @controllers << controller if /^c[0-9]+$/ =~ controller
      end
    end
  end

  # Parse disk data
  #
  # @param data [String]
  # @param controller [String]
  #
  def parse_disks!(data, controller)
    # #YELLOW
    data.lines.each do |line|
      unless line.empty?
        splitted = line.split
        if /^[p][0-9]+$/ =~ splitted[0]
          # '-' means the drive doesn't belong to any array
          # If is NOT PRESENT too, it just means this is an empty port
          status = splitted[1]
          name = splitted[0]
          unit = splitted[2]
          if unit != '-' && unit != 'NOT-PRESENT'
            # #YELLOW
            if status == 'OK' # rubocop:disable BlockNesting
              @good_disks << controller + unit + name + ': ' + status
            else
              @bad_disks << controller + unit + name + ': ' + status
            end
          end
        end
      end
    end
  end

  # Main function
  #
  def run
    exit_status, raw_data, err = execute "#{@binary} info"
    unknown "tw-cli command failed - #{err}" unless exit_status.success?
    parse_controllers! raw_data

    @controllers.each do |controller|
      exit_status, raw_data, err = execute "#{@binary} info #{controller}"
      unknown "tw-cli command failed - #{err}" unless exit_status.success?
      parse_disks! raw_data, controller
    end

    if @bad_disks.empty?
      data = @good_disks.length
      ok "All #{data} found disks are OK"
    else
      data = @bad_disks.join(', ')
      bad_count = @bad_disks.length
      good_count = @good_disks.length
      total_count = bad_count + good_count
      critical "#{bad_count} of #{total_count} disks are in bad state - #{data}"
    end
  end
end
