def random_alphanumeric(size=16)
  s = ""
  size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
  s
end

def sign_in_admin
  @admin = Factory(:user)
  sign_in @admin
  controller.stub(:current_cornerstone_user) {@admin}
  @admin.stub(:cornerstone_admin?) {true}
end

