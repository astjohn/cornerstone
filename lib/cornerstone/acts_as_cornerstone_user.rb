module Cornerstone

  module ActsAsCornerstoneUser

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods

      def acts_as_cornerstone_user(options = {})

        #= Associations
        has_many :cornerstone_discussions

        send :include, InstanceMethods
      end
    end

    module InstanceMethods

    end

  end

  ActiveRecord::Base.send :include, ActsAsCornerstoneUser

end

