require 'spec_helper'

describe Cornerstone::KnowledgebaseController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Cornerstone::Category, stubs).as_null_object
  end

  def mock_article(stubs={})
    @mock_article ||= mock_model(Cornerstone::Article, stubs).as_null_object
  end

  describe "GET index" do
    it "should expose categories for articles as @categories" do
      Cornerstone::Category.should_receive(:articles) {mock_category}
      get :index, :use_route => :cornerstone
      assigns[:categories].should equal(mock_category)
    end
  end

  describe "GET Category" do
    it "assigns the given category as @category" do
      Cornerstone::Category.stub_chain(:includes, :find).with("8") {mock_category}
      get :category, :category => "8", :use_route => :cornerstone
      assigns[:category].should == mock_category
    end
    it "assigns the given category's articles as @articles" do
      Cornerstone::Category.stub_chain(:includes, :find).with("8") {mock_category}
      mock_category.should_receive(:articles) {[mock_article]}
      get :category, :category => "8", :use_route => :cornerstone
      assigns[:articles].should == [mock_article]
    end
  end

  describe "GET Show" do
    it "assigns the article as @article" do
      Cornerstone::Article.stub(:find).with("8") {mock_article}
      get :show, :category => mock_category.id, :id => "8", :use_route => :cornerstone
      assigns[:article].should == mock_article
    end
  end

end
