require "cornerstone/engine"
require "cornerstone/acts_as_cornerstone_user"

module Cornerstone

  module Config
    #= User specified options

    # The method used to access the authenticated user
    mattr_accessor :auth_with
    @@auth_with = [:current_user]
  end

end

