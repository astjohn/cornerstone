# setup the helpers by including them into your test scope
include Warden::Test::Helpers

# DOES NOT WORK ANYMORE because cucumber uses get instead of delete
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Cucumber
#Given /^I am not authenticated$/ do
#  visit('/users/sign_out') # ensure that at least
#end

Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  User.new(:email => email,
           :password => password,
           :password_confirmation => password).save!
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  password = 'secretpass'

  Given %{I have one user "#{email}" with password "#{password}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

#Then /^I am redirected to "([^\"]*)"$/ do |url|
#  assert [301, 302].include?(@integration_session.status), "Expected status to be 301 or 302, got #{@integration_session.status}"
#  location = @integration_session.headers["Location"]
#  assert_equal url, location
#  visit location
#end

Given /I am a regular, logged in user/ do
  login_as Factory(:user, :name => "Tester")
end

Given /I am a logged in administrator/ do
  @admin = Factory(:user)
  @admin.stub!(:cornerstone_admin?) {true}
  login_as @admin
end

# # To login for the next action as "A User"
#  login_as "A User"
#  get "/foo"

#  # To login for the next action as "An Admin"
#  login_as "An Admin", :scope => :admin
#  get "/foo"

#  # Login both an admin and standard user
#  login_as "A User"
#  login_as "An Admin", :scope => :admin
#  get "/foo"


#  # setup the helpers
#  include Warden::Test::Helpers

#  # Logout all users _before_ your application receives the request
#  logout
#  get "/foo"

#  # Logout only the admin user before your application receives a result
#  logout :admin
#  get "/foo"


#  # setup the helpers
#  include Warden::Test::Helpers

#  # When you add an on_next_request block. It's executed when the request hits warden.  Once it's hit, it is consumed and does not affect further requests
#  # This example logs in a user
#  Warden.on_next_request do |proxy|
#    proxy.set_user("Some User", :scope => :foo)
#  end

