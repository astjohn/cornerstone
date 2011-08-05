module Cornerstone
  class DiscussionsController < ApplicationController

    def index
      @user = cornerstone_user
    end

    # GET /engine_root/discussions/new
    def new

    end

  end
end

