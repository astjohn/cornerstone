module Cornerstone
  class CategoriesController < ApplicationController
    authorize_cornerstone_user!

    respond_to :html

    def index
      @discussion_categories = Category.discussions
      @article_categories = Category.articles
    end

    # GET /cornerstone/categories/new
    def new
      @category = Category.new
      respond_with(@category)
    end

    # POST /cornerstone/categories/
    def create
      @category = Category.new(params[:category])
      flash[:notice] = 'Category was successfully created.' if @category.save
      respond_with(@category, :location => categories_path)
    end

    # GET /cornerstone/categories/:id/edit
    def edit
      @category = Category.find(params[:id])
      respond_with(@category)
    end

    # PUT /cornerstone/categories/:id
    def update
      @category = Category.find(params[:id])
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
      end
      respond_with(@category, :location => categories_path)
    end

    # DELETE /cornerstone/categories/:id
    def destroy
      @category = Category.find(params[:id])
      flash[:notice] = 'Category was successfully destroyed.' if @category.destroy
      respond_with(@category, :location => categories_path)
    end

  end
end

