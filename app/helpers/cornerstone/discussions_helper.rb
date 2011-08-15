module Cornerstone
  module DiscussionsHelper

    # Returns details and links about the latest discussion for a given category
    def latest_discussion_details(category)
      if discussion = category.latest_discussion
        render :partial => 'latest_discussion', :object => discussion,
                                                :locals => {:category => category}
      else
        "N/A"
      end
    end

  end
end

