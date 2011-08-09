module Cornerstone
  class DiscussionsController < ApplicationController
    respond_to :html

    def index
      @discussions = Discussion.all
      @user = cornerstone_user
    end

    # GET /cornerstone/discussions/new
    def new
      @discussion = Discussion.new
      respond_with(@discussion)
    end

  end
end

