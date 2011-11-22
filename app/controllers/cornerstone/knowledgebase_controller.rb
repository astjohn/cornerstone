module Cornerstone
  class KnowledgebaseController < ApplicationController
    respond_to :html

    # GET /knowledge/
    def index
      @categories = Category.articles
    end

    # GET /cornerstone/knowledge/:category
    def category
      @category = Category.includes(:articles).find(params[:category])
      @articles = @category.articles
      respond_with(@articles, :template => "cornerstone/knowledgebase/categorical_index")
    end

    # GET /cornerstone/knowledge/:category/:id
    def show
      @article = Article.find(params[:id])
    end

  end
end
