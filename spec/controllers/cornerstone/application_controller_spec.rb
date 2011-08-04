require 'spec_helper'

describe Cornerstone::ApplicationController do

  describe "Helpers" do

    ActionController::Base.send :include, Cornerstone::Helpers


    describe "#cornerstone_user" do

      context "with warden" do

        include Devise::TestHelpers

        before do
          Cornerstone::Config.auth_with = [:warden]
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = Factory(:user)
          sign_in @user
        end

# TODO: Make this test work
        it "should return the signed in user" #do
#          controller.cornerstone_user.should == @user
#        end

      end
    end

  end

end

