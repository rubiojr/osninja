class CheckMyIp
  extend OSNinja::Scriptlet
  supports :any
  architecture :any
  description "Get your outgoing IP address"
  hidden false
  tags :net

  def self.run
    puts "Your public IP: " + `dig +short myip.opendns.com @resolver1.opendns.com`
  end
end

