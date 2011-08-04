module Cornerstone

  # Convenience methods added to ApplicationController.
  module Helpers
    extend ActiveSupport::Concern

    included do
      helper_method :cornerstone_user
    end

    # To determine if a user from the main application is signed in
    # Returns the user object or nil
    def cornerstone_user
      if Cornerstone::Config.auth_with == :warden
        env['warden'].user
      end
    end

  end

  ActionController::Base.send :include, Cornerstone::Helpers

end

