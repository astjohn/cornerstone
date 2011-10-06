require 'spec_helper'

describe Cornerstone::ActsAsCornerstoneUser do

  class TestUser < ActiveRecord::Base
    include Cornerstone::ActsAsCornerstoneUser
  end

  class TestUserTwo < ActiveRecord::Base
    include Cornerstone::ActsAsCornerstoneUser
  end

  context "associations:" do
    before do
      TestUser.send(:acts_as_cornerstone_user)
    end

    context "for Cornerstone::Discussion" do
      it "a Cornerstone Discussion should be related to the given model (User)" do
        TestUser.reflect_on_association(:cornerstone_discussions).should_not be_nil
      end
    end

    it "a Cornerstone Post should be related to the given model (User)" do
      TestUser.reflect_on_association(:cornerstone_posts).should_not be_nil
    end

    context "belongs_to relationships" do
      it "sets up the relationship for a Discussion" do
        Cornerstone::Discussion.reflect_on_association(:user).should_not be_nil
      end

      it "sets up the relationship for a Post" do
        Cornerstone::Post.reflect_on_association(:user).should_not be_nil
      end
    end
  end

  context "options:" do
    pending "sets some default options"
    pending "sets the auth_with option"
    pending "sets the user_name option"
    pending "user_name must not be nil"
    pending "sets the user_email option"
    pending "User_email must not be nil"

  end


end

