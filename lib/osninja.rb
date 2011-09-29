require 'logger'
require 'yaml'

module OSNinja

  VERSION='0.1'
  
  Log = Logger.new $stdout
  Log.level = Logger::INFO
  if $DEBUG
    Log.level = Logger::DEBUG
  end

  class Global
    def self.current_source_file
      @current_source_file
    end

    def self.current_source_file=(file)
      @current_source_file = file
    end
  end

  class Util
    def self.parse_params(args)
      params = {}
      pos = 0
      args.each do |p|
        if p =~ /^--.*/
          key = p.dup
          key.gsub!(/^--/, '')
          params[key.gsub('-', '_').to_sym] = args[pos+1]
        end
        pos += 1
      end
      params
    end
  end

  class Config

    def self.user_data_dir
      "#{ENV['HOME']}/.osninja/"
    end

    def self.user_config_dir
      user_data_dir + 'config/'
    end

  end

  module Scriptlet

    attr_reader :description_text
    attr_reader :help_text

    def is_hidden?
      @is_hidden || false
    end

    def supported_os
      if not defined? @supported_os
        [:any]
      else
        @supported_os
      end
    end

    def tags_available
      @tags_available || []
    end

    def version_string
      @version_string || '0.0.0'
    end

    def supported_architectures
      if not defined? @supported_architectures
        [:any]
      else
        @supported_architectures
      end
    end

    def settings_array
      @settings_array || []
    end

    def parameters_array
      @parameters_array || []
    end

    def supports(*args)
      @supported_os ||= []
      @supported_os += args
    end
    
    def tags(*args)
      @tags_available ||= []
      @tags_available += args
    end

    def architecture(*args)
      @supported_architectures ||= []
      @supported_architectures += args
    end

    def source_file
      @source_file
    end
    
    #
    # Mandatory
    #
    def description(str)
      @description_text = str
    end

    def need_gems(*args)
      @need_gems ||= []
      @need_gems += args
    end

    def check_required_gems
      ok = true
      @need_gems.each do |g|
        begin
          gem g.to_s
        rescue Gem::LoadError
          $stderr.puts "\nThis command requires you to install the ruby gem #{g} first\n\n"
          ok = false
        end
      end
      ok
    end
    
    def hidden(val)
      @is_hidden = val
    end

    def parameters(*args)
      @parameters_array ||= []
      @parameters_array += args
    end

    def settings(*args)
      @settings_array ||= []
      @settings_array += args
    end
    
    def version(ver)
      @version_string = ver
    end

    #
    # Optional
    #
    def help(str)
      @help_text = str
    end

    def usage
      print "  Usage: #{command_name}"
      parameters.each do |p|
        print " --#{p} value"
      end
      puts "\n" * 2
    end

    def self.modules
      @modules ||= []
    end

    def self.extended(mod)
      mod.instance_variable_set "@source_file", File.expand_path(Global.current_source_file)
      @modules ||= []
      @modules << mod
      Log.debug "#{mod} registered"
    end

    def user_config_file
      Config.user_config_dir + File.basename(source_file.gsub(/\.rb$/, '.yml'))
    end

    def config 
      YAML.load_file(user_config_file)
    end

    def params
      @parameters
    end

    def command_name
      File.basename(source_file, '.rb').downcase.gsub('_', '-')
    end

    def write_default_config
      if not settings.empty? and not File.exist?(user_config_file)
        File.open(user_config_file, 'w') do |f|
          settings.each do |s|
            f.puts ":#{s}: changeme"
          end
        end
      end
    end

    def run_scriptlet
      if @need_gems and not check_required_gems
        exit 1
      end
      self.run
    end

  end

end
