class DiskUsage
  extend OSNinja::Scriptlet
  supports :any
  architecture :any
  description "List by size all of the directories below the current directory"
  hidden false
  tags :system

  def self.run
    puts "Calculating #{ENV['CWD']} disk usage (takes some time)..."
    puts `du -h #{ENV['CWD']} 2>/dev/null| sort -h`
  end
end
