module Cornerstone
  class HelpController < ApplicationController

    # GET /
    def index
      @discussion_categories = Category.select("name, item_count").discussions
    end

  end
end

