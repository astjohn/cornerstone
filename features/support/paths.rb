module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/cornerstone/'
    when /the discussions page/
      engine_wrap(:discussions_path)
    when /the new discussion page/
      engine_wrap(:new_discussion_path)

    when /the categories page/
      engine_wrap(:categories_path)
    when /the new category page/
      engine_wrap(:new_category_path)
    when /the edit category page for '(.+)'/
      c = Cornerstone::Category.find_by_name($1)
      engine_wrap(:edit_category_path, c)


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  # needed to access isolated engine routes from dummy app
  def engine_wrap(helper_method, args=nil)
    Cornerstone::Engine.routes.url_helpers.send(helper_method, args).to_s
  end

end

World(NavigationHelpers)

