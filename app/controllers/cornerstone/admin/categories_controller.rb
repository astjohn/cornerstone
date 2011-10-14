module Cornerstone
  class Admin::CategoriesController < Admin::ApplicationController

    respond_to :html

    def index
      @discussion_categories = Category.discussions
      @article_categories = Category.articles
    end

    # GET /cornerstone/admin/categories/new
    def new
      @category = Category.new
      respond_with(:admin, @category)
    end

    # POST /cornerstone/admin/categories/
    def create
      @category = Category.new(params[:category])
      flash[:notice] = 'Category was successfully created.' if @category.save
      respond_with(:admin, @category, :location => admin_categories_path)
    end

    # GET /cornerstone/admin/categories/:id/edit
    def edit
      @category = Category.find(params[:id])
      respond_with(:admin, @category)
    end

    # PUT /cornerstone/admin/categories/:id
    def update
      @category = Category.find(params[:id])
      flash[:notice] = 'Category was successfully updated.' if @category.update_attributes(params[:category])
      respond_with(:admin, @category, :location => admin_categories_path)
    end

    # DELETE /cornerstone/admin/categories/:id
    def destroy
      @category = Category.find(params[:id])
      flash[:notice] = 'Category was successfully destroyed.' if @category.destroy
      respond_with([:admin, @category], :location => admin_categories_path)
    end

  end
end

