# Use this hook to configure cornerstone.
Cornerstone::Config.setup do |config|

  # == Authenticated User Method
  # Specify the method in which your application accesses the authenticated user.
  # This can either be the method name (as a symbol) such as ':current_user', or
  # if your application uses warden, use ':warden'.
  # You can also use a Proc, which will get the controller as its first argument.
  # config.auth_with = Proc.new {|controller| controller.current_user}
  # Currently, only warden is supported.
  config.auth_with = :warden
  

  # == Discussion Statuses
  # An array of strings which specify the status options for a discussion.
  # The first status option becomes the default value for the database
  config.discussion_statuses = ["Open", "Resolved"]

end

