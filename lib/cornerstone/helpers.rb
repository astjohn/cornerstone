module Cornerstone

  # Convenience methods added to ApplicationController.
  module Helpers
    extend ActiveSupport::Concern

    included do
      helper_method :current_cornerstone_user, :cornerstone_admin?
    end

    module InstanceMethods

      # To determine if a user from the main application is signed in
      # Returns the user object or nil
      def current_cornerstone_user
        if Config.auth_with == :warden
          env['warden'].user if env['warden']
        elsif Config.auth_with.respond_to?(:call)
          Config.auth_with.call(self)
        end
      end

      # Return true if cornerstone_user is an administrator
      def cornerstone_admin?
        current_cornerstone_user && current_cornerstone_user.cornerstone_admin?
      end

    end

  end

  ActionController::Base.send :include, Cornerstone::Helpers

end

