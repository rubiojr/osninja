class Nma
  extend OSNinja::Scriptlet
  description "Notify My Android"
  settings :api_key
  tags :net, :android
  parameters :subject, :body

  def self.run
    require 'ruby-notify-my-android'
    NMA.notify do |n|
      n.apikey = config[:api_key]
      n.application = 'OSNinja'
      n.event = params[:subject]
      n.description = params[:body] 
    end
  end

end
