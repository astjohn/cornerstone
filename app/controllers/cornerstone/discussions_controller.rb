module Cornerstone
  class DiscussionsController < ApplicationController
    def index
      @user = cornerstone_user
    end

  end
end

