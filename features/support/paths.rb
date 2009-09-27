module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
      
    when /the login page/
      '/login'
    
    when /the OpenID authentication page/
      '/openid/create'

    when /the cloud listing page/
      clouds_path
    
    when /the new cloud page/
      new_cloud_path

    when /the server listing page/
      servers_path
    
    when /the new server page/
      new_server_path
      
    when /^cloud show page for cloud "([^\"]*)"$/i
      cloud_path(Cloud.find_by_name($1))
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
