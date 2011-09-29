#!/usr/bin/env ruby
require 'rubygems'

class AbiquoVMs
  extend OSNinja::Scriptlet

  settings :api_user, :api_password, :api_url
  description 'List all the Abiquo VMs and Hypervisors'
  tags :abiquo, :net, :cloud
  need_gems :webee

  def self.run
    include WeBee
    WeBee::Api.user = config[:api_user]
    WeBee::Api.password = config[:api_password]
    WeBee::Api.url = config[:api_url]

    include WeBee

    Datacenter.all.each do |dc|
      dc.racks.each do |rack|
        puts "Rack: #{rack.name}"
        rack.machines.each do |machine|
          puts "Machine:".green.bold + " #{machine.name} (#{machine.virtual_machines.size} VMs)"
          machine.virtual_machines.each do |vm|
            puts "  Name:".yellow.bold + " #{vm.name} " + "Enterprise:".yellow.bold + " #{vm.enterprise.name rescue ''} " + "VDC:".yellow.bold + " #{vm.vdc.name rescue ''}"
          end
        end
      end
    end
  end

end
