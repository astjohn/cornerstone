require 'spec_helper'

describe Cornerstone::Post do

  # == ACCESSIBILITY == #

  # == SCOPES == #

  # == VALIDATIONS == #

  context "validations" do

    context "without a user" do
      before do
        @post = Factory.build(:post_no_user)
      end

      [:name, :email].each do |attr|
        it "requires a #{attr.to_s}" do
          @post.send("#{attr}=", nil)
          @post.should have(1).errors_on(attr)
        end
      end

      it "#name should be 50 characters or less" do
        @post.name = random_alphanumeric(51)
        @post.should have(1).errors_on(:name)
      end

      it "allows valid emails" do
        @post.email = "youhoo@yahoo.ca"
        @post.should be_valid
      end

      it "does not allow misformed emails" do
        @post.email = "notval@id.email@@.com"
        @post.should have(1).errors_on(:email)
      end

    end

    context "with a user" do
      before do
        @post = Factory.build(:post_w_user)
      end

      it "does not require a name" do
        @post.name = nil
        @post.should have(0).errors_on(:name)
      end

      it "does not require an email" do
        @post.email = nil
        @post.should have(0).errors_on(:email)
      end

    end

    context "regarless of user present" do
      before do
        @post = Factory.build(:post)
      end

      [:body].each do |attr|
        it "requires a #{attr}" do
          @post.send("#{attr}=", nil)
          @post.should have(1).error_on(attr)
        end
      end

      it "#body should be 3000 characters or less" do
        @post.body = random_alphanumeric(3001)
        @post.should have(1).error_on(:body)
      end

    end
  end

  # == CALL BACKS == #
  context "Call Backs:" do
    describe "Counter Cache" do
      before do
        @discussion = Factory(:discussion_w_user)
      end

      it "has a reply count of 0 when first created including first post" do
        # factory creates post with discussion in callback
        @discussion.reply_count.should == 0
      end

      it "is increased when the second post is created" do
        @discussion.reply_count.should == 0
        @post = Factory(:post_no_user, :discussion => @discussion)
        @discussion.reload
        @discussion.reply_count.should == 1
      end

      it "is decreased when a post is deleted" do
        @post = Factory(:post_w_user, :discussion => @discussion)
        2.times {Factory(:post_no_user, :discussion => @discussion)}
        @discussion.reload
        @discussion.reply_count.should == 3
        @post.destroy
        @discussion.reload
        @discussion.reply_count.should == 2
      end

    end

    describe "#set_latest_post" do
      before do
        @discussion = Factory(:discussion)
      end

      pending "only updates on create"

      context "with no current user" do
        it "sets its discussion's latest post author name" do
          @post = Factory(:post_no_user, :name => "Joe Dinglebat",
                                         :discussion => @discussion)
          @discussion.reload
          @discussion.latest_post_author.should == "Joe Dinglebat"
        end
      end

      context "with a current user" do
        it "sets its discussion's latest post author name" do
          @user = Factory(:user, :name => "Joe Jingleheimershmeidt")
          @post = Factory(:post_w_user, :user => @user, :discussion => @discussion)
          @discussion.reload
          @discussion.latest_post_author.should == "Joe Jingleheimershmeidt"
        end
      end

      it "sets its category's latest discussion date" do
        time = 1.hour.from_now
        Time.stub(:now) {time}
        @post = Factory(:post_no_user, :discussion => @discussion)
        @discussion.reload
        @discussion.latest_post_date.should.to_s == time.to_s
      end

    end
  end

  # == CLASS METHODS == #

  # == INSTANCE METHODS == #
  context "Instance Methods:" do
    describe "#author_name" do
      it "returns the name if there is no user" do
        @post = Factory(:post_no_user, :name => "Jim Bob")
        @post.author_name.should == "Jim Bob"
      end
      it "returns the user's name"do
        user = Factory(:user, :name => "Alice Wundersmut")
        @post = Factory(:post_w_user, :user => user)
        @post.author_name.should == "Alice Wundersmut"
      end
    end

    describe "#author_email" do
      it "returns the email if there is no user" do
        @post = Factory(:post_no_user, :email => "jim@bob.com")
        @post.author_email.should == "jim@bob.com"
      end
      it "returns the user's name"do
        user = Factory(:user, :email => "alice@wundersmut.com")
        @post = Factory(:post_w_user, :user => user)
        @post.author_email.should == "alice@wundersmut.com"
      end
    end
  end

end

