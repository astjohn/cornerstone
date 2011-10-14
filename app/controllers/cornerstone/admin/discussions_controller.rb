module Cornerstone
  class Admin::DiscussionsController < Admin::ApplicationController

    respond_to :html

    # GET /cornerstone/admin/discussions/:id/edit
    def edit
      @discussion = Discussion.includes(:posts => :user).find(params[:id])
      @categories = Category.discussions
      respond_with(:admin, @discussion)
    end

    # PUT /cornersone/admin/discussions/:id
    def update
      @discussion = Discussion.includes(:posts => :user).find(params[:id])

      respond_with(@discussion.category, @discussion) do |format|
        if @discussion.update_attributes(params[:discussion])
          flash[:notice] = "Discussion was successfully updated."
          format.html {redirect_to category_discussion_path(@discussion.category, @discussion)}
        else
          @categories = Category.discussions
          format.html {render :edit}
        end
      end

    end


  end
end

