# Use this hook to configure cornerstone.
Cornerstone::Config.setup do |config|

  # == Authenticated User Method
  # Specify the method in which your application accesses the authenticated user.
  # You may use a Proc to call a helper method in your application.  The helper method
  # must return an authenticated user.
  # Alternatively, you may specify ':warden' if you are using Warden for authentication.
  #
  # Examples:
  #
  # config.auth_with = Proc.new {|helper| helper.current_user}
  # config.auth_with = :warden
  config.auth_with = :warden


  # == Discussion Statuses
  # An array of strings which specify the status options for a discussion.
  # The first status option becomes the default value used in the database.
  # The last status option becomes the default value when a discussion is 'closed.'
  config.discussion_statuses = ["Open", "Resolved"]

end

