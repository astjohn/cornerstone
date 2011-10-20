require 'spec_helper'

describe Cornerstone::PostObserver do
  describe "#after_create" do

    context "new discussion" do
      it "sends the new discussion email" do
        discussion = Factory(:discussion_w_user)
        post = discussion.posts.first
        @observer = Cornerstone::PostObserver.instance

        mailer = mock("mailer")
        Cornerstone::CornerstoneMailer.should_receive(:new_discussion)
                                      .with(post, discussion) {mailer}
        mailer.should_receive(:deliver)

        @observer.after_create(post)
      end
    end

    context "existing discussion" do
      before do
        @discussion = Factory(:discussion_w_user)
        @post = Factory(:post_w_user, :discussion => @discussion)
      end
      it "sends the new post email" do
        @observer = Cornerstone::PostObserver.instance

        mailer = mock("mailer")
        Cornerstone::CornerstoneMailer.should_receive(:new_post)
                                      .with(@discussion.posts.first.author_name,
                                            @discussion.posts.first.author_email,
                                            @post, @discussion) {mailer}
        mailer.should_receive(:deliver)

        @observer.after_create(@post)
      end

      it "sends the new post email to multiple customers" do
        @observer = Cornerstone::PostObserver.instance

        post2 = Factory(:post_w_user, :discussion => @discussion)

        mailer = mock("mailer")
        mailer.stub(:deliver)
        Cornerstone::CornerstoneMailer.should_receive(:new_post).twice {mailer}

        @observer.after_create(post2)
      end
    end

  end
end
