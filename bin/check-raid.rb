#! /usr/bin/env ruby
#
#   check-raid
#
# DESCRIPTION:
#   Generic raid check
#   Supports HP, Adaptec, and MegaRAID controllers. Also supports software RAID.
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#
# NOTES:
#
# LICENSE:
# Originally by Shane Feek, modified by Alan Smith. Date: 07/14/2014#
# Released under the same terms as Sensu (the MIT license); see LICENSE  for details.
#

require 'sensu-plugin/check/cli'

#
# Check Raid
#
class CheckRaid < Sensu::Plugin::Check::CLI
  # Check software raid
  #
  def check_software
    if File.exist?('/proc/mdstat')
      contents = File.read('/proc/mdstat')
      mg = contents.lines.grep(/active|blocks/)
      unless mg.empty?
        sg = mg.to_s.lines.grep(/\]\(F\)|[\[U]_/)
        unless sg.empty? # rubocop:disable UnlessElse
          warning 'Software RAID warning'
        else
          ok 'Software RAID OK'
        end
      end
    end
  end

  # Check HP raid
  #
  def check_hp
    if File.exist?('/usr/bin/cciss_vol_status')
      contents = `/usr/bin/cciss_vol_status /dev/sg0`
      c = contents.lines.grep(/status\: OK\./)
      # #YELLOW
      unless c.empty? # rubocop:disable UnlessElse
        ok 'HP RAID OK'
      else
        warning 'HP RAID warning'
      end
    end
  end

  # Check Adaptec raid controllers
  #
  def check_adaptec
    if File.exist?('/usr/StorMan/arcconf')
      contents = `/usr/StorMan/arcconf GETCONFIG 1 AL`

      mg = contents.lines.grep(/Controller Status/)
      # #YELLOW
      unless mg.empty? # rubocop:disable UnlessElse
        sg = mg.to_s.lines.grep(/Optimal/)
        warning 'Adaptec Physical RAID Controller Failure' if sg.empty?
      else
        warning 'Adaptec Physical RAID Controller Status Read Failure'
      end

      mg = contents.lines.grep(/Status of logical device/)
      # #YELLOW
      unless mg.empty? # rubocop:disable UnlessElse
        sg = mg.to_s.lines.grep(/Optimal/)
        warning 'Adaptec Logical RAID Controller Failure' if sg.empty?
      else
        warning 'Adaptec Logical RAID Controller Status Read Failure'
      end

      mg = contents.lines.grep(/S\.M\.A\.R\.T\.   /)
      # #YELLOW
      unless mg.empty? # rubocop:disable UnlessElse
        sg = mg.to_s.lines.grep(/No/)
        warning 'Adaptec S.M.A.R.T. Disk Failed' if sg.empty?
      else
        warning 'Adaptec S.M.A.R.T. Status Read Failure'
      end

      ok 'Adaptec RAID OK'
    end
  end

  # Check Megaraid
  #
  def check_mega_raid
    if File.exist?('/usr/sbin/megacli')
      contents = `/usr/sbin/megacli -AdpAllInfo -aALL`
      failed = contents.lines.grep(/(Critical|Failed) Disks\s+\: 0/)
      degraded = contents.lines.grep(/Degraded\s+\: 0/)
      # #YELLOW
      unless failed.empty? || degraded.empty? # rubocop:disable UnlessElse
        ok 'MegaRaid RAID OK'
      else
        warning 'MegaRaid RAID warning'
      end
    end
  end

  # Main function
  #
  def run
    check_software
    unless `lspci`.lines.grep(/RAID/).empty?
      check_hp
      check_adaptec
      check_mega_raid

      unknown 'Missing software for RAID controller'
    end

    ok 'No RAID present'
  end
end
