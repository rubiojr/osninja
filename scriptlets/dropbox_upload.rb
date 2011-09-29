class DropboxUpload
  extend OSNinja::Scriptlet

  description 'Uploads a file to Dropbox and prints the public URL'
  tags :cloud, :net, :sharing
  settings :email, :password, :app_key, :app_secret
  need_gems :dropbox
  parameters :file

  def self.run
    require 'dropbox'
    file = params[:file]
    drop = Dropbox::Session.new(config[:app_key], config[:app_secret])
    drop.mode = :dropbox
    if not File.exist?(user_config_file + '.session')
      puts "Visit #{drop.authorize_url} to log in to Dropbox. Hit enter when you have done this."
      $stdin.gets
      drop.authorize
      File.open(user_config_file + '.session', 'w') do |f|
        f.puts drop.serialize
      end
    else
      drop = Dropbox::Session.deserialize(File.read(user_config_file + '.session'))
    end

    # Create osninja dir if it does not exist
    begin
      d = drop.file '/Public/osninja'
    rescue Dropbox::FileNotFoundError
      drop.create_folder '/Public/osninja'
    end
    drop.upload file, '/Public/osninja/'
    puts "http://dl.dropbox.com/u/#{drop.account.uid}/osninja/#{File.basename(file)}"
  end

end
