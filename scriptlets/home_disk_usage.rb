class HomeDiskUsage
  extend OSNinja::Scriptlet
  supports :any
  architecture :any
  description "List by size all of the directories in your home directory"
  hidden false
  tags :system

  def self.run
    puts "Calculating #{ENV['HOME']} disk usage (takes some time)..."
    puts `du -h #{ENV['HOME']} 2>/dev/null| sort -h`
  end
end
