require 'spec_helper'

describe Cornerstone::Helpers do
  include Warden::Test::Helpers

  class TestController < Cornerstone::ApplicationController
    include Cornerstone::Helpers
  end

  describe "#current_cornerstone_user" do

    context "using warden" do
      pending "should return the current signed in user"
    end

    context "using a Proc" do
      pending "should return the current signed in user"
    end

  end
  describe "#cornerstone_admin?" do
    context "no current user" do
      pending "should return false"
    end
    context "with a current user" do
      pending "should return false if the user is not an admin"
      pending "should return false if the user is an admin"
    end
  end

end

