require 'spec_helper'

describe Cornerstone::PostsController do

  def mock_discussion(stubs={})
    @mock_discussion ||= mock_model(Cornerstone::Discussion, stubs).as_null_object
  end

  describe "POST create" do
    before do
      @discussion = Factory(:discussion)
    end

    it "finds and exposes the discussion as @discussion" do
      post :create, :discussion_id => @discussion.id, :post => {}, :use_route => :cornerstone
      assigns[:discussion].should == @discussion
    end

    it "exposes a newly created post as @post from the params" do
      attrs = Factory.attributes_for(:post)
      post :create, :discussion_id => @discussion.id, :post => attrs, :use_route => :cornerstone
      assigns[:post].body.should == attrs[:body]
      assigns[:post].discussion.should == @discussion
    end

    it "sets the current user if there is one" do
      @user = Factory(:user)
      sign_in @user
      attrs = Factory.attributes_for(:post)
      controller.stub!(:current_cornerstone_user) {@user}
      post :create, :discussion_id => @discussion.id, :post => attrs, :use_route => :cornerstone
      assigns[:post].user.should == @user
    end
    
    context "with valid parameters" do
      before do
        Cornerstone::Post.any_instance.stub(:save) {true}      
      end
      it "redirects to the discussion" do
        attrs = Factory.attributes_for(:post)
        post :create, :discussion_id => @discussion.id, :post => attrs, :use_route => :cornerstone
        response.should redirect_to(discussion_path(@discussion.category, @discussion))
      end

      context "discussion status" do
        it "is changed to closed if params dictate" do
          attrs = Factory.attributes_for(:post)
          post :create, :discussion_id => @discussion.id, :post => attrs, 
                        :comment_close => true, :use_route => :cornerstone
          @discussion.reload.status.should == Cornerstone::Discussion::STATUS.last
        end
        it "is changed to open if discussion was previously closed" do
          @discussion.status = Cornerstone::Discussion::STATUS.last
          @discussion.save!
          attrs = Factory.attributes_for(:post)
          post :create, :discussion_id => @discussion.id, :post => attrs, 
                        :use_route => :cornerstone
          @discussion.reload.status.should == Cornerstone::Discussion::STATUS.first        
        end
      end
    end

    context "with invalid parameters" do
      before do
        Cornerstone::Post.any_instance.stub(:save) {false}
      end

      it "assigns a new post as @new_post" do
        post :create, :discussion_id => @discussion.id, :post => {}, :use_route => :cornerstone
        assigns[:new_post].should be_a_new(Cornerstone::Post)
      end

      it "assigns the existing posts as @posts" do
        p = Factory(:post_no_user, :discussion => @discussion)
        post :create, :discussion_id => @discussion.id, :post => {}, :use_route => :cornerstone
        assigns[:posts].should == [p]
      end

      it "renders the discussion show template" do
        post :create, :discussion_id => @discussion.id, :post => {}, :use_route => :cornerstone
        response.should render_template "cornerstone/discussions/show"
      end
    end

  end

  pending "edit"
  pending "UPDATE"
  pending "destroy"

end

