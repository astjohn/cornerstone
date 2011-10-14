module Cornerstone
  class Admin::ArticlesController < Admin::ApplicationController

    respond_to :html

    def index
      @articles = Article.all
      respond_with(:admin, @articles)
    end

    def show
      @article = Article.find(params[:id])
      respond_with(:admin, @article)
    end

    # GET /cornerstone/admin/articles/new
    def new
      @article = Article.new
      @categories = Category.articles
      respond_with(:admin, @articles)
    end

    # POST /cornerstone/admin/articles/
    def create
      @article = Article.new(params[:article])
      if @article.save
        flash[:notice] = 'Article was successfully created.'
      else
        @categories = Category.articles
      end
      respond_with(:admin, @article)
    end

    # GET /cornerstone/admin/articles/:id/edit
    def edit
      @article = Article.find(params[:id])
      @categories = Category.articles
      respond_with(:admin, @article)
    end

    # PUT /cornerstone/admin/articles/:id
    def update
      @article = Article.find(params[:id])
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
      else
        @categories = Category.articles
      end
      respond_with(:admin, @article)
    end

    # DELETE /cornerstone/admin/articles/:id
    def destroy
      @article = Article.find(params[:id])
      flash[:notice] = 'Article was successfully destroyed.' if @article.destroy
      respond_with(:admin, @article, :location => admin_articles_path)
    end

  end
end

