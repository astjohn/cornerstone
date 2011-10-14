require 'spec_helper'

describe Cornerstone::Admin::DiscussionsController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Cornerstone::Category, stubs).as_null_object
  end

  def mock_discussion(stubs={})
    @mock_discussion ||= mock_model(Cornerstone::Discussion, stubs).as_null_object
  end

  describe "GET edit" do
    context "with an administrator" do
      before do
        sign_in_admin
      end
      it "assigns the discussion as @discussion" do
        Cornerstone::Discussion.stub_chain(:includes, :find) {mock_discussion}
        get :edit, :id => "2", :use_route => :cornerstone
        assigns(:discussion).should eql(mock_discussion)
      end

      it "exposes discussion categories for selection as @categories" do
        Cornerstone::Discussion.stub_chain(:includes, :find) {mock_discussion}
        Cornerstone::Category.should_receive(:discussions) {[mock_category]}
        get :edit, :id => "2", :use_route => :cornerstone
        assigns(:categories).should eql([mock_category])
      end
    end

    context "with a normal user" do
      it "raises the unauthorized error" do
        lambda {
          get :edit, :id => "2", :use_route => :cornerstone
        }.should raise_error(Cornerstone::AccessDenied)
      end
    end
  end

  describe "PUT update" do
    context "with an administrator" do
      before do
        sign_in_admin
      end
      it "exposes the discussion as @discussion" do
        Cornerstone::Discussion.stub_chain(:includes, :find).with("8") {mock_discussion}
        put :update, :id => "8", :discussion => {}, :use_route => :cornerstone
        assigns[:discussion].should == mock_discussion
      end

      it "updates the requested discussion with the given parameters" do
        Cornerstone::Discussion.stub_chain(:includes, :find).with("8") {mock_discussion}
        mock_discussion.should_receive(:update_attributes).with({"these" => "params"})
        put :update, :id => "8", :discussion => {"these" => "params"},
                                  :use_route => :cornerstone
      end
      context "with valid parameters" do
        before do
          Cornerstone::Discussion.stub_chain(:includes, :find).with("8")
                                 .and_return(mock_discussion(:update_attributes => true))
        end

        it "redirects to the discussion" do
          put :update, :id => "8", :discussion => {"these" => "params"},
                                    :use_route => :cornerstone
          response.should redirect_to(category_discussion_path(mock_discussion.category, mock_discussion))
        end
      end
      context "with invalid parameters" do
        before do
          Cornerstone::Discussion.stub_chain(:includes, :find).with("8")
                                 .and_return(mock_discussion(:update_attributes => false))
        end

        it "renders the edit template" do
          put :update, :id => "8", :discussion => {},
                                    :use_route => :cornerstone
          response.should render_template :edit
        end
      end
    end
    context "with a normal user" do
      it "raises the unauthorized error" do
        lambda {
          get :edit, :id => "2", :use_route => :cornerstone
        }.should raise_error(Cornerstone::AccessDenied)
      end
    end
  end

  pending "DESTROY"

end

