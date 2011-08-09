require 'spec_helper'

describe Cornerstone::CategoriesController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Cornerstone::Category, stubs).as_null_object
  end

  describe "GET index" do
    it "exposes all discussion categories as @discussion_categories" do
      Cornerstone::Category.should_receive(:discussions) {[mock_category]}
      get :index, :use_route => :cornerstone
      assigns[:discussion_categories].should == [mock_category]
    end
    it "exposes all article categories as @article_categories" do
      Cornerstone::Category.should_receive(:articles) {[mock_category]}
      get :index, :use_route => :cornerstone
      assigns[:article_categories].should == [mock_category]
    end
  end

  describe "GET new" do
    it "exposes a new category as @category" do
      Cornerstone::Category.should_receive(:new) {mock_category}
      get :new, :use_route => :cornerstone
      assigns[:category].should == mock_category
    end
  end

  describe "POST create" do
    context "with valid parameters" do
      it "exposes a newly created category as @category" do
        Cornerstone::Category.should_receive(:new)
                             .with({'these' => 'params'}) {mock_category :save => true}
        post :create, :category => {:these => 'params'}, :use_route => :cornerstone
        assigns(:category).should equal(mock_category)
      end

      it "redirects to the category list" do
        Cornerstone::Category.stub!(:new) {mock_category(:save => true)}
        post :create, :category => {}, :use_route => :cornerstone
        response.should redirect_to(categories_path)
      end
    end

    context "with invalid parameters" do
      it "exposes a newly created but unsaved category as @category" do
        Cornerstone::Category.stub!(:new)
                             .with({'these' => 'params'}) {mock_category(:save => false)}
        post :create, :category => {:these => 'params'}, :use_route => :cornerstone
        assigns(:category).should equal(mock_category)
      end

      it "re-renders the 'new' template" do
        Cornerstone::Category.stub!(:new) {mock_category(:save => false)}
        post :create, :category => {}, :use_route => :cornerstone
        response.should render_template(:new)
      end
    end

  end

  describe "GET edit" do
    it "exposes the requested category as @category" do
      Cornerstone::Category.should_receive(:find).with("37") {mock_category}
      get :edit, :id => "37", :use_route => :cornerstone
      assigns[:category].should equal(mock_category)
    end
  end

  describe "PUT update" do

    it "exposes the requested category as @category" do
      Cornerstone::Category.should_receive(:find).with("37") {mock_category}
      put :update, :id => "37", :category => {"these" => "params"},
                                :use_route => :cornerstone
      assigns[:category].should equal(mock_category)
    end

    it "updates the requested category with the given parameters" do
      Cornerstone::Category.should_receive(:find).with("37") {mock_category}
      mock_category.should_receive(:update_attributes).with({"these" => "params"})
      put :update, :id => "37", :category => {"these" => "params"},
                                :use_route => :cornerstone
    end

    describe "with valid parameters" do
      before do
        Cornerstone::Category.stub(:find).with("37")
                             .and_return(mock_category(:update_attributes => true))
      end

      it "redirects to the category list" do
        put :update, :id => "37", :category => {"these" => "params"},
                                  :use_route => :cornerstone
        response.should redirect_to(categories_path)
      end

    end

    describe "with invalid parameters" do
      before do
        Cornerstone::Category.stub(:find).with("37")
                             .and_return(mock_category(:update_attributes => false))
      end

      it "renders the edit page" do
        put :update, :id => "37", :category => {}, :use_route => :cornerstone
        response.should render_template :edit
      end
    end

  end

  describe "DELETE destroy" do
    it "exposes the category as @category" do
      Cornerstone::Category.should_receive(:find).with("37") {mock_category}
      delete :destroy, :id => "37", :use_route => :cornerstone
      assigns[:category].should equal(mock_category)
    end

    it "redirects to the category list when destroyed" do
      Cornerstone::Category.stub(:find) {mock_category(:destroy => true)}
      delete :destroy, :id => "37", :use_route => :cornerstone
      response.should redirect_to(categories_path)
    end

    it "redirects to the category list when not destroyed" do
      Cornerstone::Category.stub(:find) {mock_category(:destroy => false)}
      delete :destroy, :id => "37", :use_route => :cornerstone
      response.should redirect_to(categories_path)
    end

#    it "redirects to the unedited alerts list" do
#      Alert.stub!(:find).and_return(mock_alert)
#      mock_alert.should_receive(:trash!).and_return(:false)
#      delete :destroy, :id => "1"
#      response.should redirect_to(unedited_alerts_path)
#    end

  end


end

