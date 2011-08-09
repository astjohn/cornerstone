require 'spec_helper'

describe Cornerstone::HelpController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Cornerstone::Category, stubs)
  end

  describe "GET index" do

    it "exposes all discussion categories as @discussion_categories" do
      Cornerstone::Category.stub_chain(:select, :discussions) {mock_category}
      get :index, :use_route => :cornerstone
      assigns[:discussion_categories].should == mock_category
    end

  end

end

