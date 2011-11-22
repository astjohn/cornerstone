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

    # Mailer 'from' address
    mattr_accessor :mailer_from
    @@mailer_from = "no-reply@cornerstone.com"

    # List of admin emails
    mattr_accessor :admin_emails
    @@admin_emails = []

    # Sanitize Options
    mattr_accessor :sanitize_options
    @@sanitize_options = Sanitize::Config::BASIC

  end

end
