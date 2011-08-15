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

    it "it exposes discussion categories for selection as @categories" do
      Cornerstone::Category.should_receive(:discussions) {mock_category}
      get :new, :use_route => :cornerstone
      assigns(:categories).should equal(mock_category)
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
        response.should redirect_to(discussion_path(mock_category, mock_discussion))
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

end

