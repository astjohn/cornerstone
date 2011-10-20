module Cornerstone

  module ActsAsCornerstoneUser

    extend ActiveSupport::Concern

    included do
      userclass = self.name

      # == Associations
      has_many :cornerstone_discussions, :foreign_key => :user_id,
                                         :class_name => "::Cornerstone::Discussion"
      has_many :cornerstone_posts, :foreign_key => :user_id,
                                   :class_name => "::Cornerstone::Post"

      # TODO: dependent destroy? - how to handle when user account deleted?
      #                          - perhaps this can be an option specified in initializer

      # == Accessibility
      cattr_accessor :cornerstone_name_method, :cornerstone_email_method,
                     :cornerstone_admin

      # TODO: Might need support for multiple user models such as AdminUser... etc.
      # send belongs_to user relationships
      Cornerstone::Discussion.send(:belongs_to, :user, :class_name => userclass)
      Cornerstone::Post.send(:belongs_to, :user, :class_name => userclass)
    end

    module ClassMethods

      # Method placed within User model of parent application and used to set
      # Cornerstone options for the model.
      def acts_as_cornerstone_user(options = {})
        # == Options

        # TODO: CHECK that the methods given actually exist and raise error if not
        #       CHECK that values given are good types
        self.cornerstone_name_method = options[:user_name] if options[:user_name]
        self.cornerstone_email_method = options[:user_email] if options[:user_email]
        self.cornerstone_admin = options[:admin] if options[:admin]
      end
    end

    module InstanceMethods

      # return the user's name
      def cornerstone_name
        if self.cornerstone_name_method.present?
          self.send(self.cornerstone_name_method)
        else
          "Not Available"
        end
      end

      # return the user's email
      def cornerstone_email
        if self.cornerstone_email_method.present?
          self.send(self.cornerstone_email_method)
        else
          "Not Available"
        end
      end

      # Return true if this user is an administrator
      def cornerstone_admin?
        case
        when self.cornerstone_admin.is_a?(TrueClass)
          true
        when self.cornerstone_admin.respond_to?(:call)
          self.cornerstone_admin.call
        else
          false
        end
      end
    end

  end

end
