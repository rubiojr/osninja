class ListCommands
  extend OSNinja::Scriptlet

  description "List available commands"
  tags        :core, :osninja

  def self.run
    puts "Available commands:"
    (Scriptlet.modules.sort{ |a,b| a.command_name <=> b.command_name }).each do |m|
      next if m.is_hidden?
      puts "    #{m.command_name}".ljust(40) + m.description_text
    end
  end

end
