module Cornerstone
  class PostsController < ApplicationController
    respond_to :html

    # POST /cornerstone/discussions/:discussion_id/posts
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
          # close discussion if commit param dictates
          unless params[:comment_close].nil?
            @discussion.update_attribute(:status, Discussion::STATUS.last)
          else
            # re-open discussion if discussion is closed
            if @discussion.closed?
              @discussion.update_attribute(:status, Discussion::STATUS.first)
            end
          end

          flash[:notice] = 'Comment was successfully created.'
          format.html {redirect_to category_discussion_path(@discussion.category, @discussion)}
        else
          @new_post = @post
          @posts = existing_posts
          format.html {render :template => "cornerstone/discussions/show"}
        end
      end
    end
    
    # GET /cornerstone/discussions/:discussion_id/posts/:id/edit
    def edit
      @post = Post.includes(:user, :discussion).find(params[:id])
      raise Cornerstone::AccessDenied unless @post.created_by?(current_cornerstone_user)
      @discussion = @post.discussion
      respond_with(@discussion, @post)
    end

    # PUT /cornerstone/discussions/:discussion_id/posts/:id
    def update
      @post = Post.includes(:user, :discussion).find(params[:id])
      raise Cornerstone::AccessDenied unless @post.created_by?(current_cornerstone_user)
      @discussion = @post.discussion
      flash[:notice] = "Post was successfully updated." if @post.update_attributes(params[:post])
      respond_with(@discussion, @post, :location => category_discussion_path(@discussion.category, @discussion))
    end

  end
end

