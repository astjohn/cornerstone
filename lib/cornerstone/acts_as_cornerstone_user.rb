module Cornerstone

  module ActsAsCornerstoneUser

    extend ActiveSupport::Concern

    module ClassMethods

      def acts_as_cornerstone_user(options = {})

        # == Associations
        has_many :cornerstone_discussions

        # == Options

      end
    end

    module InstanceMethods

    end

  end

  ActiveRecord::Base.send :include, ActsAsCornerstoneUser

end

