require "cornerstone/engine"
require "cornerstone/acts_as_cornerstone_user"
require "cornerstone/helpers"

module Cornerstone

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

  end

end

