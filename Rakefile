require 'rubygems'
require 'lib/osninja'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.version = OSNinja::VERSION
  gem.name = "osninja"
  gem.homepage = "http://github.com/rubiojr/osninja"
  gem.license = "MIT"
  gem.summary = %Q{The Library of Alexandria, at your fingertips}
  gem.description = %Q{Easily extensible collection of scripts to rule'em all}
  gem.email = "rubiojr@frameos.org"
  gem.authors = ["Sergio Rubio"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  gem.add_runtime_dependency 'term-ansicolor'
  gem.add_runtime_dependency 'rest-client'
  gem.add_runtime_dependency 'highline'
  gem.add_runtime_dependency 'run-as-root'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :build

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "osninja #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
