require 'spec_helper'

describe Cornerstone::Discussion do

  # == SCOPES == #

  # == VALIDATIONS == #

  context "validations" do

    context "without a user" do
      before do
        @discussion = Factory.build(:discussion_no_user)
      end

      [:name, :email].each do |attr|
        it "requires a #{attr.to_s}" do
          @discussion.send("#{attr}=", nil)
          @discussion.should have(1).errors_on(attr)
        end
      end

      it "#name should be 50 characters or less" do
        @discussion.name = random_alphanumeric(51)
        @discussion.should have(1).errors_on(:name)
      end

      it "allows valid emails" do
        @discussion.email = "youhoo@yahoo.ca"
        @discussion.should be_valid
      end

      it "does not allow misformed emails" do
        @discussion.email = "notvalid.email@@.com"
        @discussion.should have(1).errors_on(:email)
      end

    end

    context "with a user" do
      before do
        @discussion = Factory.build(:discussion_w_user)
      end

      it "does not require a name" do
        @discussion.name = nil
        @discussion.should have(0).errors_on(:name)
      end

      it "does not require an email" do
        @discussion.email = nil
        @discussion.should have(0).errors_on(:email)
      end

    end

    context "regarless of user present" do
      before do
        @discussion = Factory.build(:discussion)
      end

      [:subject, :body].each do |attr|
        it "requires a #{attr}" do
          @discussion.send("#{attr}=", nil)
          @discussion.should have(1).error_on(attr)
        end
      end

      it "#subject should be 50 characters or less" do
        @discussion.subject = random_alphanumeric(51)
        @discussion.should have(1).error_on(:subject)
      end

      it "#body should be 3000 characters or less" do
        @discussion.body = random_alphanumeric(3001)
        @discussion.should have(1).error_on(:body)
      end
    end

  end

  # == CALLBACKS == #
  # == CLASS METHODS == #
  # == INSTANCE METHODS == #

end

