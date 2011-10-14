module Cornerstone
  class Admin::ApplicationController < ::ApplicationController
    authorize_cornerstone_admin!

  end
end

