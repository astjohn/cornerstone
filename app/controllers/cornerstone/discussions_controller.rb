module Cornerstone
  class DiscussionsController < ApplicationController
    authorize_cornerstone_admin! :only => [:edit, :update]

    respond_to :html

    # GET /cornerstone/discussions/
    def index
      @categories = Category.discussions
    end

    # GET /cornerstone/discussions/new
    def new
      @categories = Category.discussions
      @category = Category.find(params[:cat]) if params[:cat]
      @discussion = Discussion.new
      @discussion.category_id = @category.id if @category
      @discussion.posts.build
      respond_with(@discussion)
    end

    # GET /cornerstone/discussions/:category
    def category
      @category = Category.includes(:discussions => :posts).find(params[:category])
      @discussions = @category.discussions
      respond_with(@discussions, :template => "cornerstone/discussions/categorical_index")
    end

    # GET /cornerstone/discussions/:category/:id
    def show
      @discussion = Discussion.includes(:posts => :user).find(params[:id])
      @new_post = Post.new
      @posts = @discussion.posts
    end

    # POST /cornerstone/discussions/
    def create
      @discussion = Discussion.new(params[:discussion])

      # assign user if signed in
      if current_cornerstone_user
        @discussion.user = current_cornerstone_user
        @discussion.posts.first.user = current_cornerstone_user
      end

      respond_with(@discussion.category, @discussion) do |format|
        if @discussion.save
          flash[:notice] = 'Discussion was successfully created.'
          format.html {redirect_to discussion_path(@discussion.category, @discussion)}
        else
          @categories = Category.discussions
          format.html {render :new}
        end
      end
    end

    # Only administrator
    # GET /cornerstone/discussions/:id/edit
    def edit
      @discussion = Discussion.includes(:posts => :user).find(params[:id])
      @categories = Category.discussions
    end

  end
end

