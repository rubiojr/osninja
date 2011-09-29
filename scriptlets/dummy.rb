class DummyScriptlet
  extend OSNinja::Scriptlet
  supports :rhel5, :rhel6, :fedora14, :fedora15
  architecture :x86_64, :i386
  description "Dummy scriptlet"
  hidden true
  parameters :foo, :bar

  def self.run
    puts "dummy"
  end
end

