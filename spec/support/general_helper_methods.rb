def random_alphanumeric(size=16)
  s = ""
  size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
  s
end


def sign_in_admin(admin=nil)
  @admin = admin || Factory(:user)
  login_as @admin
  controller.stub(:current_cornerstone_user) {@admin} if controller
  @admin.stub(:cornerstone_admin?) {true}
end

def sign_in_user(user=nil)
  @user = user || Factory(:user)
  login_as @user
  controller.stub(:current_cornerstone_user) {@user} if controller
  @user.stub(:cornerstone_admin?) {false}
end
