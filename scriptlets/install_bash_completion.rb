class InstallBashCompletion
  extend OSNinja::Scriptlet

  description "Install bash completion script for OSNinja"
  tags        :core, :osninja
  need_gems 'run-as-root'

  def self.run
    require 'run-as-root'
    FileUtils.cp(File.dirname(__FILE__) + "/../extra/bash_completion/osninja.sh", "/etc/bash_completion.d/osninja.sh")
  end

end
