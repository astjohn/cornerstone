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
    when /the discussion page for '(.+)'/
      d = Cornerstone::Discussion.find_by_subject($1)
      engine_wrap(:discussion_path, d.category, d)
    when /the discussion category page for '(.+)'/
      c = Cornerstone::Category.find_by_name($1)
      engine_wrap(:discussions_category_path, c)

    when /the categories page/
      engine_wrap(:categories_path)
    when /the new category page/
      engine_wrap(:new_category_path)
    when /the edit category page for '(.+)'/
      c = Cornerstone::Category.find_by_name($1)
      engine_wrap(:edit_category_path, c)

    when /the articles page/
      engine_wrap(:articles_path)
    when /the new article page/
      engine_wrap(:new_article_path)
    when /the article show page for '(.+)'/
      a = Cornerstone::Article.find_by_title($1)
      engine_wrap(:article_path, a)
    when /the edit article page for '(.+)'/
      a = Cornerstone::Article.find_by_title($1)
      engine_wrap(:edit_article_path, a)

    # Pickle Paths - TODO: Does this work with isolated enigne paths???
    when /^#{capture_model}(?:'s)? page$/
      # eg. the forum's page
      path_to_pickle $1
    when /^#{capture_model}(?:'s)? #{capture_model}(?:'s)? page$/
      # eg. the forum's page
      path_to_pickle $1, $2
    when /^#{capture_model}(?:'s)? #{capture_model}'s (.+?) page$/
      # eg. the forum's post's comments page
      #  or the forum's post's edit page
      path_to_pickle $1, $2, :extra => $3
    when /^#{capture_model}(?:'s)? (.+?) page$/
      # eg. the forum's posts page
      #  or the forum's edit page
      path_to_pickle $1, :extra => $2

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
  def engine_wrap(helper_method, *args)
    Cornerstone::Engine.routes.url_helpers.send(helper_method, *args).to_s
  end

end

World(NavigationHelpers)

