class ShareDirHTTP
  extend OSNinja::Scriptlet

  description "Serve current directory tree at http://my-host-ip:8000"
  supports :any
  architecture :any
  tags :net, :sharing

  def self.run
    puts "Serving the current directory at http://my-host-ip:8000"
    puts `python -m SimpleHTTPServer`
  end
end
  
