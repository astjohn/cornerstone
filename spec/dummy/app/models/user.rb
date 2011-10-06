class User < ActiveRecord::Base
  include Cornerstone::ActsAsCornerstoneUser

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  acts_as_cornerstone_user :user_name => :name, :user_email => :email

end

