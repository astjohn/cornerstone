require 'spec_helper'

describe Cornerstone::ActsAsCornerstoneUser do

  class User < ActiveRecord::Base
    acts_as_cornerstone_user
  end

  context "associations:" do
    it "a Cornerstone Discussion should be related to the given model (User)" do
      User.reflect_on_association(:cornerstone_discussions).should_not be_nil
    end
  end


end

