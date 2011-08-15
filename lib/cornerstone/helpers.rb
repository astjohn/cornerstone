module Cornerstone

  # Convenience methods added to ApplicationController.
  module Helpers
    extend ActiveSupport::Concern

    included do
      helper_method :current_cornerstone_user
    end

    # To determine if a user from the main application is signed in
    # Returns the user object or nil
    def current_cornerstone_user
      if Config.auth_with == :warden
        env['warden'].user if env['warden']
      else
        # TODO: this could be a spot to call a user specified helper.
        #       need to call helper belonging to parent app.

      end
    end

  end

  ActionController::Base.send :include, Cornerstone::Helpers

end

