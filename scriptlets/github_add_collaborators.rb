class GithubAddCollaborators
  extend OSNinja::Scriptlet

  description "Create a public repo in Github"
  parameters :repo, :collabs
  settings :github_user, :github_token
  tags :github, :cloud, :net

  def self.run
    params[:collabs].split(',').each do |c|
      RestClient.post "http://github.com/api/v2/yaml/repos/collaborators/#{config[:github_user]}/#{params[:repo]}/add/#{c}", 
                      :login => config[:github_user], 
                      :token => config[:github_token]
    end
  end

end
