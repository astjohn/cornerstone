module Cornerstone

  module ActsAsCornerstoneUser

    extend ActiveSupport::Concern

    module ClassMethods

      def acts_as_cornerstone_user(options = {})

        userclass = self.to_s.underscore.to_sym

        # == Associations
        has_many :cornerstone_discussions, :foreign_key => :user_id,
                                           :class_name => "Cornerstone::Discussions"
        has_many :cornerstone_posts, :foreign_key => :user_id,
                                     :class_name => "Cornerstone::Posts"

        # TODO: dependent destroy? - how to handle when user account deleted?
        #                          - perhaps this can be an option specified in initializer


        # TODO: Might need support for multiple user models such as AdminUser... etc.
        # send belongs_to user relationships
        Cornerstone::Discussion.send(:belongs_to, :user, :class_name => userclass)
        Cornerstone::Post.send(:belongs_to, :user, :class_name => userclass)


        # == Options

        # TODO: CHECK that the methods given actually exist and raise error if not
        Cornerstone::Config.user_name = options[:user_name] if options[:user_name]
        Cornerstone::Config.user_email = options[:user_email] if options[:user_email]

      end
    end

    module InstanceMethods

    end

  end

  ActiveRecord::Base.send :include, ActsAsCornerstoneUser

end

