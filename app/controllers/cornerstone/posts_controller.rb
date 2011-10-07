module Cornerstone
  class PostsController < ApplicationController
    respond_to :html

    # POST /cornerstone/discussions/:id/posts
    def create
      @discussion = Discussion.includes(:posts => :user).find(params[:discussion_id])
      existing_posts = @discussion.posts.dup
      @post = @discussion.posts.new(params[:post])

      # assign user if signed in
      if current_cornerstone_user
        @post.user = current_cornerstone_user
      end

      respond_with(@discussion, @post) do |format|
        if @post.save
          flash[:notice] = 'Comment was successfully created.'
          format.html {redirect_to discussion_path(@discussion.category, @discussion)}
        else
          @new_post = Post.new
          @posts = existing_posts
          format.html {render :template => "cornerstone/discussions/show"}
        end
      end
    end

    # PUT /cornerstone/discussions/:id/posts/:id
    def update
    end

  end
end

