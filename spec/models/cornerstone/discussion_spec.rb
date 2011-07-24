require 'spec_helper'

describe Cornerstone::Discussion do

  context "validations" do
    before do
      @discussion = Factory(:discussion)
    end

    it "should be valid" do
      @discussion.should be_valid
    end

  end

end

