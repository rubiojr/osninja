class SortInsalledRPMSBySize
  extend OSNinja::Scriptlet

  description "Sort installed RPMS by size"
  architecture :x86_64, :i386
  supports :rhel, :fedora
  tags :system, :redhat, :rpm

  def self.run
    puts `rpm -q -a --qf '%10{SIZE} bytes\t%{NAME}\n' | sort -k1,1n`
  end
end 
