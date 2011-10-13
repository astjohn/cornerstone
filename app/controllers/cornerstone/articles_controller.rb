module Cornerstone
  class ArticlesController < ApplicationController
    authorize_cornerstone_admin!

    respond_to :html

    def index
      @articles = Article.all
      respond_with(@articles)
    end

    def show
      @article = Article.find(params[:id])
      respond_with(@article)
    end

    # GET /cornerstone/articles/new
    def new
      @article = Article.new
      @categories = Category.articles
      respond_with(@articles)
    end

    # POST /cornerstone/articles/
    def create
      @article = Article.new(params[:article])
      if @article.save
        flash[:notice] = 'Article was successfully created.'
      else
        @categories = Category.articles
      end
      respond_with(@article)
    end

    # GET /cornerstone/articles/:id/edit
    def edit
      @article = Article.find(params[:id])
      @categories = Category.articles
      respond_with(@article)
    end

    # PUT /cornerstone/articles/:id
    def update
      @article = Article.find(params[:id])
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
      else
        @categories = Category.articles
      end
      respond_with(@article)
    end

    # DELETE /cornerstone/articles/:id
    def destroy
      @article = Article.find(params[:id])
      flash[:notice] = 'Article was successfully destroyed.' if @article.destroy
      respond_with(@article, :location => articles_path)
    end

  end
end

