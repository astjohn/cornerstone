module Cornerstone

  # Convenience methods added to ApplicationController.
  module ControllerAdditions
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      # Returns true if user is authorized for controller action, otherwise
      # raise error
      def authorize_cornerstone_user!(*args)
        self.before_filter(*args) do |controller|
          raise Cornerstone::AccessDenied unless cornerstone_admin?
        end
      end
    end

  end

  ActionController::Base.send :include, Cornerstone::ControllerAdditions

end

