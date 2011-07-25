require 'spec_helper'

describe Cornerstone::ActsAsCornerstoneUser do

  class TestUser < ActiveRecord::Base
  end

  context "associations:" do
    it "a Cornerstone Discussion should be related to the given model (User)" do
      TestUser.send(:acts_as_cornerstone_user)
      TestUser.reflect_on_association(:cornerstone_discussions).should_not be_nil
    end
  end

  context "options:" do
    describe "#auth_with" do
      before do
        Cornerstone::Config.auth_with = [:current_user]
      end

      it "can handle a user specified authentication method" do
        TestUser.send(:acts_as_cornerstone_user, {:auth_with => :some_method})
        Cornerstone::Config.auth_with.should == [:current_user, :some_method]
      end

      it "can handle multiple authentication methods" do
        TestUser.send(:acts_as_cornerstone_user, {:auth_with => [:some_method1,
                                                                 :some_method2]})
        Cornerstone::Config.auth_with.should == [:current_user,
                                                 :some_method1,
                                                 :some_method2]
      end

    end
  end


end

