module Cornerstone

  module ActsAsCornerstoneUser

    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
    end

    module ClassMethods

      def acts_as_cornerstone_user(options = {})

        #= Associations
        has_many :cornerstone_discussions


        #= Options
        Cornerstone::Config.auth_with << options[:auth_with] if options[:auth_with]
        Cornerstone::Config.auth_with.flatten!

      end
    end

    module InstanceMethods

    end

  end

  ActiveRecord::Base.send :include, ActsAsCornerstoneUser

end

