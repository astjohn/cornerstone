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

  end


end

