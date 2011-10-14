require 'spec_helper'

describe Cornerstone::Admin::ArticlesController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Cornerstone::Category, stubs).as_null_object
  end

  def mock_article(stubs={})
    @mock_article ||= mock_model(Cornerstone::Article, stubs).as_null_object
  end

  describe "GET index" do
    context "with an administrator" do
      before do
        sign_in_admin
      end
      it "should expose articles as @articles" do
        Cornerstone::Article.should_receive(:all) {[mock_article]}
        get :index, :use_route => :cornerstone
        assigns[:articles].should eql([mock_article])
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

  describe "GET show" do
    context "with an administrator" do
      before do
        sign_in_admin
      end
      it "should expose the requested article as @article" do
        Cornerstone::Article.should_receive(:find).with("37") {mock_article}
        get :show, :id => "37", :use_route => :cornerstone
        assigns[:article].should eql(mock_article)
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

  describe "GET new" do
    context "with an administrator" do
      before do
        sign_in_admin
      end
      it "should expose a new article as @article" do
        Cornerstone::Article.should_receive(:new) {mock_article}
        get :new, :use_route => :cornerstone
        assigns[:article].should equal(mock_article)
      end

      it "exposes article categories for selection as @categories" do
        Cornerstone::Category.should_receive(:articles) {mock_category}
        get :new, :use_route => :cornerstone
        assigns(:categories).should equal(mock_category)
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
    context "with an administrator" do
      before do
        sign_in_admin
      end
      context "with valid parameters" do
        it "exposes a newly created article as @article" do
          Cornerstone::Article.should_receive(:new)
                               .with({'these' => 'params'}) {mock_article :save => true}
          post :create, :article => {:these => 'params'}, :use_route => :cornerstone
          assigns(:article).should equal(mock_article)
        end

        it "redirects to the article" do
          Cornerstone::Article.stub!(:new) {mock_article(:save => true,
                                                               :category => mock_category)}
          post :create, :article => {}, :use_route => :cornerstone
          response.should redirect_to(admin_article_path(mock_article))
        end

      end

      context "with invalid parameters" do
        before do
          Cornerstone::Article.stub!(:new) {mock_article(:save => false)}
        end

        it "exposes a newly created but unsaved article as @article" do
          post :create, :article => {}, :use_route => :cornerstone
          assigns(:article).should equal(mock_article)
        end

        it "exposes article categories for selection as @categories" do
          Cornerstone::Category.should_receive(:articles) {mock_category}
          post :create, :article => {}, :use_route => :cornerstone
          assigns(:categories).should equal(mock_category)
        end

        it "re-renders the 'new' template" do
          post :create, :article => {}, :use_route => :cornerstone
          response.should render_template(:new)
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

  describe "GET edit" do
    context "with an administrator" do
      before do
        sign_in_admin
      end
      it "exposes the requested article as @article" do
        Cornerstone::Article.should_receive(:find).with("37") {mock_article}
        get :edit, :id => "37", :use_route => :cornerstone
        assigns[:article].should equal(mock_article)
      end
      it "exposes article categories for selection as @categories" do
        Cornerstone::Article.should_receive(:find).with("37") {mock_article}
        Cornerstone::Category.should_receive(:articles) {mock_category}
        get :edit, :id => "37", :use_route => :cornerstone
        assigns(:categories).should equal(mock_category)
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
      it "exposes the requested article as @article" do
        Cornerstone::Article.should_receive(:find).with("37") {mock_article}
        put :update, :id => "37", :article => {"these" => "params"},
                                  :use_route => :cornerstone
        assigns[:article].should equal(mock_article)
      end

      it "updates the requested category with the given parameters" do
        Cornerstone::Article.should_receive(:find).with("37") {mock_article}
        mock_article.should_receive(:update_attributes).with({"these" => "params"})
        put :update, :id => "37", :article => {"these" => "params"},
                                  :use_route => :cornerstone
      end

      describe "with valid parameters" do
        before do
          Cornerstone::Article.stub(:find).with("37")
                               .and_return(mock_article(:update_attributes => true))
        end

        it "redirects to the article" do
          put :update, :id => "37", :article => {"these" => "params"},
                                    :use_route => :cornerstone
          response.should redirect_to(admin_article_path(mock_article))
        end

      end

      describe "with invalid parameters" do
        before do
          Cornerstone::Article.stub(:find).with("37")
                               .and_return(mock_article(:update_attributes => false))
        end

        it "renders the edit page" do
          put :update, :id => "37", :article => {}, :use_route => :cornerstone
          response.should render_template :edit
        end
        it "exposes article categories for selection as @categories" do
          Cornerstone::Category.should_receive(:articles) {mock_category}
          put :update, :id => "37", :article => {}, :use_route => :cornerstone
          assigns(:categories).should equal(mock_category)
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

  describe "DELETE destroy" do
    context "with an administrator" do
      before do
        sign_in_admin
      end
      it "exposes the article as @article" do
        Cornerstone::Article.should_receive(:find).with("37") {mock_article}
        delete :destroy, :id => "37", :use_route => :cornerstone
        assigns[:article].should equal(mock_article)
      end

      it "redirects to the article list when destroyed" do
        Cornerstone::Article.stub(:find) {mock_article(:destroy => true)}
        delete :destroy, :id => "37", :use_route => :cornerstone
        response.should redirect_to(admin_articles_path)
      end

      it "redirects to the article list when not destroyed" do
        Cornerstone::Article.stub(:find) {mock_article(:destroy => false)}
        delete :destroy, :id => "37", :use_route => :cornerstone
        response.should redirect_to(admin_articles_path)
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

end

