require 'spec_helper'

feature "Cornerstone emails" do

  background do
  end

  scenario "Sent to administrators when a discussion is created" do
    category = Factory(:category, :name => "General Help",
                                  :category_type => "Discussion")
    visit discussions_path
    click_link("New Discussion")

    select category.name, :from => "discussion_category_id"
    fill_in "Subject", :with => "I need help!"
    fill_in "Name", :with => "Waffles"
    fill_in "Email", :with => "w@ihop.com"
    fill_in "post_body", :with => "Please help me out. k thx."
    click_button "Create"

    d = Cornerstone::Discussion.find_by_subject("I need help!")
    current_path.should match category_discussion_path(category, d)

    emails.size.should == 2
    emails.first.to.should == ["admins@cornerstone.com"]
    emails.second.to.should == ["w@ihop.com"]
  end

  scenario "Sent to other participants when reply is created" do
    user = Factory(:user, :name => "New guy")
    sign_in_user(user)
    discussion = Factory(:discussion_w_user, :user => user)
    reply1 = Factory(:post, :discussion => discussion,
                            :name => "Reply Author",
                            :email => "email@email.com")
    reply2 = Factory(:post, :discussion => discussion,
                            :name => "Reply2 Author",
                            :email => "email2@email.com")
    emails.clear

    visit category_discussion_path(discussion.category, discussion)
    fill_in "post_body", :with => "Final reply."
    click_button "Comment"
    current_path.should match category_discussion_path(discussion.category, discussion)

    emails.size.should == 2
    emails.first.to.should == ["email@email.com"]
    emails.last.to.should == ["email2@email.com"]
  end

end
