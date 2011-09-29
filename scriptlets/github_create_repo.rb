class GithubCreateRepo
  extend OSNinja::Scriptlet

  description "Create a public repo in Github"
  parameters :name
  settings :github_user, :github_token
  tags :github, :cloud, :net

  def self.run
    RestClient.post "http://github.com/api/v2/yaml/repos/create", 
                    :login => config[:github_user], 
                    :token => config[:github_token], 
                     :name => params[:name] 
  end

end
