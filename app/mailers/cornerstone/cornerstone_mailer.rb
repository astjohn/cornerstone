module Cornerstone
  class CornerstoneMailer < ActionMailer::Base
    default from: Cornerstone::Config.mailer_from

    # Email admins on new discussion - refer to post observer
    def new_discussion(post, discussion)
      @post = post
      @discussion = discussion
      mail :to => Cornerstone::Config.admin_emails
    end

    # Email a single participant within a discussion - refer to post observer
    def new_post(name, email, post, discussion)
      @post = post
      @discussion = discussion
      @name = name

      mail :to => email,
           :subject => I18n.t('cornerstone.cornerstone_mailer.new_post.subject',
                              :topic => @discussion.subject)
    end

  end
end
