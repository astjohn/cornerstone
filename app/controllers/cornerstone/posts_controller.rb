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

    # TODO
    # PUT /cornerstone/discussions/:id/posts/:id
    def update
    end

  end
end

