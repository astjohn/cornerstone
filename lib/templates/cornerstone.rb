# Use this hook to configure cornerstone.
Cornerstone::Config.setup do |config|

  # == Authenticated User Method
  # Specify the method in which your application accesses the authenticated user.
  # This can either be the method name (as a symbol) such as ':current_user', or
  # if your application uses warden, use ':warden'.
  # Currently, only warden is supported.
  config.auth_with = :warden


end

