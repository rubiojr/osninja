class ListOpenFiles 
  extend OSNinja::Scriptlet
  supports :rhel5, :rhel6, :fedora14, :fedora15
  architecture :x86_64, :i386
  description "Discovering all open files/dirs"
  hidden false
  tags :system
  need_gems 'run-as-root'

  def self.run
    require 'run-as-root'
    puts `lsof +D / -n 2> /dev/null`
  end
end
