class TesterController < ApplicationController
  def index
    @user = current_cornerstone_user
  end

end

