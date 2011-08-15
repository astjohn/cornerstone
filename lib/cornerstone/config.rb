module Cornerstone

  # This module stores configuration options for Cornerstone
  module Config

    # Configure Cornerstone. Run rails generate cornerstone_install to create
    # a fresh initializer with all configuration values.
    def self.setup
      yield self
    end


    # == User specified options

    # The method used to access the authenticated user
    mattr_accessor :auth_with
    @@auth_with = :warden

    # Discussion Statuses
    mattr_accessor :discussion_statuses
    @@discussion_statuses = ["Open", "Resolved"]

    # Method on user object which returns the name attribute
    mattr_accessor :user_name
    @@user_name = nil

    # Method on user object which returns the email attribute
    mattr_accessor :user_email
    @@user_email = nil

  end

end

