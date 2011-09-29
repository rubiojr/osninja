class CloudAppUpload
  extend OSNinja::Scriptlet

  description 'Uploads a file to Cloudapp and prints the public URL'
  tags :cloud, :net, :sharing
  settings :email, :password
  need_gems :cloudapp_api
  parameters :file

  def self.run
    require 'cloudapp_api'
    file = params[:file]
    if file.nil? or not File.exist?(file)
      $stderr.puts "\nInvalid file\n"
      puts "\nUsage: cloudapp <path-to-file>\n\n"
      exit 1
    end
    drop = CloudApp.authenticate config[:email], config[:password]

    begin
      drop = CloudApp::Drop.create :upload, :file => file, :private => false
      url = drop.remote_url
      puts url
      IO.popen("xsel --clipboard", mode='w') do |io|
          io.write url 
      end
    rescue Exception => e
      $stderr.puts "Error uploading file. Upload limit reached?"
    end
  end

end
