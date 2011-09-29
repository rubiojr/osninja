#!/usr/bin/env ruby
require 'rubygems'
require 'webee'
require 'md5'
require 'terminal-table/import'
require 'term/ansicolor'

class AbiquoCloudStats
  extend OSNinja::Scriptlet

  settings :api_user, :api_password, :api_url
  description 'List top 10 VM users in Abiquo'
  tags :abiquo, :net, :cloud
  need_gems :webee, :alchemist

  def self.run
    include WeBee
    Alchemist::use_si = true
    WeBee::Api.user = config[:api_user]
    WeBee::Api.password = config[:api_password]
    WeBee::Api.url = config[:api_url]

    stats = {
      :free_hd => 0, 
      :real_hd => 0,
      :used_hd => 0, 
      :hypervisors => 0,
      :free_ram => 0,
      :real_ram => 0,
      :used_ram => 0,
      :available_cpus => 0
    }

    Datacenter.all.each do |dc|
      dc.racks.each do |rack|
        puts "#" * 80
        puts "Rack: #{rack.name} Datacenter: #{dc.name}".red.bold
        rack.machines.each do |m|
          puts "#" * 80
          stats[:hypervisors] += 1
          stats[:used_ram] += m.ram_used.to_i
          stats[:real_ram] += m.real_ram.to_i
          stats[:available_cpus] += m.real_cpu.to_i
          stats[:used_hd] += m.hd_used.to_i.bytes.to.gigabytes.to_f.round
          stats[:real_hd] += m.real_hd.to_i.bytes.to.gigabytes.to_f.round
          ds_table = table do |t|
            t.headings = "Datastores"
            m.datastores.each do |ds|
              t << ["Name:       ".yellow,"#{ds.name}"]
              t << ["Enabled:    ".yellow,"#{ds.enabled}"]
              t << ["Size:       ".yellow,"#{ds.size.to_i.bytes.to.gigabytes.to_i} GB"]
              t << ["Used Size:  ".yellow,"#{ds.used_size.to_i.bytes.to.gigabytes.to_i} GB"]
            end
          end
          user_table = table do 
            self.headings = "  #{m.name.upcase.green.bold}"
            add_row ["IP:".yellow, "#{m.ip}"]
            add_row ["CPUs:".yellow, "#{m.real_cpu}"]
            add_row ["State:".yellow, "#{m.state}"]
            add_row ["Hypervisor Type:".yellow,"#{m.hypervisortype}"]
            add_row ["RAM:".yellow,"#{m.real_ram.to_i} MB"]
            add_row ["RAM Used:".yellow,"#{m.ram_used.to_i} MB"]
            add_row ["RAM Free:".yellow,"#{m.real_ram.to_i - m.ram_used.to_i} MB"]
            add_row ["HD Size:".yellow,"#{m.real_hd.to_i.bytes.to.gigabytes.to_i} GB"]
            add_row ["HD Used:".yellow,"#{m.hd_used.to_i.bytes.to.gigabytes.to_i} GB"]
            add_row ["HD Free:".yellow,"#{(m.real_hd.to_i - m.hd_used.to_i).bytes.to.gigabytes.to_i} GB"]
            add_row ["CPU Used:".yellow,"#{m.cpu_used.to_i}"]
          end
          puts user_table
          puts ds_table
          puts "#" * 80
          puts "\n\n"
        end
      end
    end

    stats[:free_ram] = stats[:real_ram] - stats[:used_ram]
    stats[:free_hd] = stats[:real_hd] - stats[:used_hd]

    puts "\n"
    puts "#" * 80
    puts "Cloud Stats".red.bold
    puts "#" * 80
    user_table = table do
      self.headings = ['Cloud Statistics']
      add_row ["Hypevisors:".yellow, "#{stats[:hypervisors]}"]
      add_row ["Available CPUs:".yellow, "#{stats[:available_cpus]}"]
      add_row ["Total RAM:".yellow,"#{stats[:real_ram].megabytes.to.gigabytes} GB"]
      add_row ["Free RAM:".yellow,"#{stats[:free_ram].megabytes.to.gigabytes} GB"]
      add_row ["Used RAM:".yellow,"#{stats[:used_ram].megabytes.to.gigabytes} GB"]
      add_row ["Total HD:".yellow, "#{stats[:real_hd]} GB"]
      add_row ["Free HD:".yellow, "#{stats[:free_hd]} GB"]
      add_row ["Used HD:".yellow, "#{stats[:used_hd]} GB"]
    end
    puts user_table
    puts "#" * 80
  end
end
