require 'spec_helper'

describe Cornerstone::DiscussionsController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Cornerstone::Category, stubs).as_null_object
  end

  def mock_discussion(stubs={})
    @mock_discussion ||= mock_model(Cornerstone::Discussion, stubs).as_null_object
  end

  describe "GET index" do
    it "should expose categories for discussion as @categories" do
      Cornerstone::Category.should_receive(:discussions) {mock_category}
      get :index, :use_route => :cornerstone
      assigns[:categories].should equal(mock_category)
    end
  end

  describe "GET new" do
    it "should expose a new discussion as @discussion" do
      Cornerstone::Discussion.should_receive(:new) {mock_discussion}
      get :new, :use_route => :cornerstone
      assigns[:discussion].should equal(mock_discussion)
    end

    it "should build a post for the first post of the discussion" do
      Cornerstone::Discussion.stub(:new) {mock_discussion}
      posts_assoc = mock("posts assoc")
      post = mock_model(Cornerstone::Post).as_null_object
      mock_discussion.should_receive(:posts) {posts_assoc}
      posts_assoc.should_receive(:build) {post}
      get :new, :use_route => :cornerstone
    end

    it "should set the discussion's category if given in parameters" do
      Cornerstone::Category.should_receive(:find).with("1") {mock_category}
      Cornerstone::Discussion.should_receive(:new) {mock_discussion}
      get :new, :cat => "1", :use_route => :cornerstone
    end

    it "should not set the discussion's category if not given param[:cat]" do
      Cornerstone::Category.should_not_receive(:find)
      Cornerstone::Discussion.should_receive(:new) {mock_discussion}
      get :new, :use_route => :cornerstone
    end

    it "exposes discussion categories for selection as @categories" do
      Cornerstone::Category.should_receive(:discussions) {[mock_category]}
      get :new, :use_route => :cornerstone
      assigns(:categories).should eql([mock_category])
    end

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


  describe "POST create" do
    context "with valid parameters" do
      it "exposes a newly created discussion as @discussion" do
        Cornerstone::Discussion.should_receive(:new)
                             .with({'these' => 'params'}) {mock_discussion :save => true}
        post :create, :discussion => {:these => 'params'}, :use_route => :cornerstone
        assigns(:discussion).should equal(mock_discussion)
      end

      it "redirects to the discussion" do
        Cornerstone::Discussion.stub!(:new) {mock_discussion(:save => true,
                                                             :category => mock_category)}
        post :create, :discussion => {}, :use_route => :cornerstone
        response.should redirect_to(category_discussion_path(mock_category, mock_discussion))
      end

      context "and a logged in user" do
        before do
          @user = Factory(:user)
          sign_in @user
          Cornerstone::Discussion.stub!(:new) {mock_discussion(:save => true,
                                                   :category => mock_category)}
          controller.stub!(:current_cornerstone_user) {@user}
        end

        it "should assign the logged in user as the owner of the discussion" do
          mock_discussion.stub(:user=).with(@user)
          post :create, :discussion => {}, :use_route => :cornerstone
        end

        it "should assign the logged in user as the owner of the post" do
          posted = mock_model(Cornerstone::Post).as_null_object
          posts = mock("posts")
          mock_discussion.should_receive(:posts) {posts}
          posts.should_receive(:first) {posted}
          posted.should_receive(:user=).with(@user)
          post :create, :discussion => {}, :use_route => :cornerstone
        end
      end
    end

    context "with invalid parameters" do
      before do
        Cornerstone::Discussion.stub!(:new) {mock_discussion(:save => false)}
      end

      it "exposes a newly created but unsaved discussion as @discussion" do
        post :create, :discussion => {}, :use_route => :cornerstone
        assigns(:discussion).should equal(mock_discussion)
      end

      it "it exposes discussion categories for selection as @categories" do
        Cornerstone::Category.should_receive(:discussions) {mock_category}
        post :create, :discussion => {}, :use_route => :cornerstone
        assigns(:categories).should equal(mock_category)
      end

      it "re-renders the 'new' template" do
        post :create, :discussion => {}, :use_route => :cornerstone
        response.should render_template(:new)
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


  describe "GET Category" do
    it "assigns the given category as @category" do
      Cornerstone::Category.stub_chain(:includes, :find).with("8") {mock_category}
      get :category, :category => "8", :use_route => :cornerstone
      assigns[:category].should == mock_category
    end
    it "assigns the given category's discussions as @discussions" do
      Cornerstone::Category.stub_chain(:includes, :find).with("8") {mock_category}
      mock_category.should_receive(:discussions) {[mock_discussion]}
      get :category, :category => "8", :use_route => :cornerstone
      assigns[:discussions].should == [mock_discussion]
    end
  end

  describe "GET Show" do
    it "assigns the discussion as @discussion" do
      Cornerstone::Discussion.stub_chain(:includes, :find).with("8") {mock_discussion}
      get :show, :category => mock_category.id, :id => "8", :use_route => :cornerstone
      assigns[:discussion].should == mock_discussion
    end
    it "assigns the discussion's posts as @posts" do
      Cornerstone::Discussion.stub_chain(:includes, :find).with("8") {mock_discussion}
      mock_post = mock_model(Cornerstone::Post).as_null_object
      mock_discussion.should_receive(:posts) {[mock_post]}
      get :show, :category => mock_category.id, :id => "8", :use_route => :cornerstone
      assigns[:posts].should == [mock_post]
    end
    it "creates a new post for the reply form" do
      Cornerstone::Discussion.stub_chain(:includes, :find).with("8") {mock_discussion}
      get :show, :category => mock_category.id, :id => "8", :use_route => :cornerstone
      assigns[:new_post].should be_a_new(Cornerstone::Post)
    end
  end

  pending "DESTROY"

end

