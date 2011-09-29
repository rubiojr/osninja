class WgetAll 
  extend OSNinja::Scriptlet
  supports :any
  architecture :any
  description "Download all files of a certain type with wget to the current dir"
  hidden false
  parameters :url, :extension
  tags :net

  def self.run
    puts "Downloading all #{params[:extension]} files from #{params[:url]}..."
    `wget --quiet -r -l2 -nd -Nc -A.#{params[:extension]} #{params[:url]}`
  end
end
