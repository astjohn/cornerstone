require 'spec_helper'

describe Cornerstone::PostsController do

  def mock_discussion(stubs={})
    @mock_discussion ||= mock_model(Cornerstone::Discussion, stubs).as_null_object
  end
  
  def mock_post(stubs={})
    @mock_post ||= mock_model(Cornerstone::Post, stubs).as_null_object
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
        response.should redirect_to(category_discussion_path(@discussion.category, @discussion))
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

  describe "GET edit" do
    
    it "assigns the post as @post" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
      get :edit, :discussion_id => "2", :id => "8", :use_route => :cornerstone
      assigns[:post].should == mock_post
    end
    
    it "assigns the post's discussion as @discussion" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
      mock_post.should_receive(:discussion) {mock_discussion}
      get :edit, :discussion_id => "2", :id => "8", :use_route => :cornerstone
      assigns[:discussion].should == mock_discussion
    end
    
    it "should render the edit template" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
      get :edit, :discussion_id => "2", :id => "8", :use_route => :cornerstone
      response.should render_template :edit    
    end

    it "raises Cornerstone::AccessDenied if the user did not create the post" do
      user = Factory(:user)
      sign_in user
      user2 = Factory(:user)
      post = Factory(:post_w_user, :user => user2)
      
      lambda {
        get :edit, :discussion_id => "2", :id => post.id, :use_route => :cornerstone
      }.should raise_error(Cornerstone::AccessDenied)
    end  
  end
  
  describe "PUT update" do
    it "assigns the post as @post" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
      put :update, :discussion_id => "2", :id => "8", :post => {}, :use_route => :cornerstone
      assigns[:post].should == mock_post   
    end
    
    it "assigns the post's discussion as @discussion" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
      mock_post.should_receive(:discussion) {mock_discussion}
      put :update, :discussion_id => "2", :id => "8", :post => {}, :use_route => :cornerstone
      assigns[:discussion].should == mock_discussion       
    end
    
    it "raises Cornerstone::AccessDenied if the user did not create the post" do
      user = Factory(:user)
      sign_in user
      user2 = Factory(:user)
      post = Factory(:post_w_user, :user => user2)
      
      lambda {
        put :update, :discussion_id => "2", :id => post.id, :post => {}, 
                     :use_route => :cornerstone
      }.should raise_error(Cornerstone::AccessDenied)
    end
    
    context "with valid parameters" do
      it "updates the post with the params" do
        Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
        mock_post.should_receive(:update_attributes).with("these" => "params") {true}
        mock_post.stub(:discussion) {mock_discussion}
        put :update, :discussion_id => "2", :id => "8", :post => {"these" => "params"}, 
                                                        :use_route => :cornerstone
      end
      it "redirects to the discussion" do
        Cornerstone::Post.any_instance.stub(:update_attributes) {true}
        Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
        mock_post.stub(:discussion) {mock_discussion}
        put :update, :discussion_id => "2", :id => "8", :post => {}, :use_route => :cornerstone
        response.should redirect_to category_discussion_path(mock_discussion.category, mock_discussion)
      end
    end
    context "with in-valid parameters" do
# TODO: spec not working for render
#      it "renders the edit page" do
#        Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
#        mock_post.should_receive(:update_attributes) {false}
#        mock_post.stub(:discussion) {mock_discussion}
#        put :update, :discussion_id => "2", :id => "8", :post => {}, :use_route => :cornerstone
#        response.should render_template :edit
#      end
    end
  end
  
  describe "DELETE destroy" do
    it "assigns the post as @post" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
      mock_post.stub(:discussion) {mock_discussion}
      delete :destroy, :discussion_id => "2", :id => "8", :use_route => :cornerstone
      assigns[:post].should == mock_post   
    end
    
    it "assigns the post's discussion as @discussion" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post}
      mock_post.should_receive(:discussion) {mock_discussion}
      delete :destroy, :discussion_id => "2", :id => "8", :use_route => :cornerstone
      assigns[:discussion].should == mock_discussion       
    end
    
    it "redirects to the discussion" do
      Cornerstone::Post.stub_chain(:includes, :find).with("8") {mock_post(:destroy => true)}
      mock_post.stub(:discussion) {mock_discussion}
      delete :destroy, :discussion_id => "2", :id => "8", :use_route => :cornerstone
      response.should redirect_to category_discussion_path(mock_discussion.category, mock_discussion)
    end

    it "raises Cornerstone::AccessDenied if the user did not create the post" do
      user = Factory(:user)
      sign_in user
      user2 = Factory(:user)
      post = Factory(:post_w_user, :user => user2)
      
      lambda {
        delete :destroy, :discussion_id => "2", :id => post.id, :use_route => :cornerstone
      }.should raise_error(Cornerstone::AccessDenied)
    end    
  end

end

