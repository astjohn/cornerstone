module Cornerstone
  class PostObserver < ActiveRecord::Observer

    def after_create(post)
      discussion = post.discussion
      if discussion.posts.count == 1
        # If first post (i.e. start of new discussion), email admin list
        CornerstoneMailer.new_discussion(post, discussion).deliver

        # Also email user of the first post to let them know all is good.
        CornerstoneMailer.new_discussion_user(post, discussion).deliver
      else
        # If not first post, email participants of discussion

        # do not email the author of this newly created post
        discussion.participants(post.author_email).each do |p|
          CornerstoneMailer.new_post(p[0], p[1], post, discussion).deliver
        end
      end
    end

  end
end
