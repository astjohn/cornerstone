module Cornerstone

  module ActsAsCornerstoneUser

    extend ActiveSupport::Concern

    module ClassMethods

      def acts_as_cornerstone_user(options = {})

        # == Associations
        has_many :cornerstone_discussions, :foreign_key => :user_id
        # TODO: dependent destroy? - how to handle when no user

        # send belongs_to user relationships
        Cornerstone::Discussion.send(:belongs_to, self.to_s.underscore.to_sym)

        # == Options

      end
    end

    module InstanceMethods

    end

  end

  ActiveRecord::Base.send :include, ActsAsCornerstoneUser

end

