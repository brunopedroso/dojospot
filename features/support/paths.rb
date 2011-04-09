module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /página inicial/
      '/'
    when /the home page/
      '/'

    when /lista de sessões/
      '/dojo_sessions'

    when /next sessions page/
      '/dojo_sessions'

    when /the past sessions listing/
			'/history'
    when /the history page/
			'/history'

    when /the session detail page/
			/\/dojo_sessions\/\d+/

    when /the edit profile page/
			'/edit_profile'

    when /página de login/
      '/login'

    when /login page/
      '/login'

    when /página de nova sessão/
      '/dojo_sessions/new'

    when /new session page/
      '/dojo_sessions/new'

		when /Sobre coding-dojo?/
			'/pages/sobre_coding_dojo'

		when /About coding-dojo?/
			'/pages/sobre_coding_dojo'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
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
