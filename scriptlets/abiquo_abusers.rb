#!/usr/bin/env ruby
require 'rubygems'

class String
	include Term::ANSIColor
end

class AbiquoAbusers
  extend OSNinja::Scriptlet

  settings :api_user, :api_password, :api_url
  description 'List top 10 VM users in Abiquo'
  tags :abiquo, :net, :cloud
  need_gems :webee

  def self.run
    include WeBee
    WeBee::Api.user = config[:api_user]
    WeBee::Api.password = config[:api_password]
    WeBee::Api.url = config[:api_url]

    include WeBee

    abusers = {}

    Enterprise.all.each do |ent|
      ent.users.each do |user|
        abusers[user.name] = { :full_name => "#{user.name} #{user.surname}", :email => user.email, :vms_number => user.virtual_machines.size, :vms => user.virtual_machines }
      end
    end

    abusers = abusers.sort do |a,b|
      a[1][:vms_number] <=> b[1][:vms_number]
    end.reverse

    abusers.reverse.each do |a|
      if a[1][:vms_number] > 0
        puts "User: ".yellow.bold + "#{a[1][:full_name]}".ljust(40) + "VMs: ".yellow.bold + "#{a[1][:vms_number]}"
        a[1][:vms].each do |vm|
      puts "  VM Name: ".green.bold + "#{vm.name}".ljust(50) + " VRDP Port:".green.bold + "#{vm.vrdp_port}"
        end
      end
    end
  end
end
