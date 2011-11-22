require 'spec_helper'

feature "Interact with the Knowledge Base" do

  background do
    @c1 = Factory(:category, :name => "FAQ's",
                             :category_type => "Article")
    @c2 = Factory(:category, :name => "How To's",
                             :category_type => "Article")
  end

  scenario "See what articles are available" do
    visit knowledge_base_path
    page.should have_content(@c1.name)
    page.should have_content(@c2.name)
  end

  scenario "Select a category and then an article" do
    a = Factory(:article, :title => "How do I Create a Widget?",
                          :body => "This is how you create a widget",
                          :category => @c1)
    visit knowledge_base_path
    page.should have_content(@c1.name)
    click_link(@c1.name)
    current_path.should match articles_category_path(@c1)

    page.should have_content(a.title)
    click_link(a.title)
    current_path.should match category_article_path(@c1, a)

    page.should have_content(a.title)
    page.should have_content(a.body)
  end

#  scenario "Create a new discussion when not logged in" do
#    visit discussions_path
#    click_link("New Discussion")

#    select @c1.name, :from => "discussion_category_id"
#    fill_in "Subject", :with => "I need help!"
#    fill_in "Name", :with => "Waffles"
#    fill_in "Email", :with => "w@ihop.com"
#    fill_in "post_body", :with => "Please help me out. k thx."
#    click_button "Create"

#    d = Cornerstone::Discussion.find_by_subject("I need help!")
#    current_path.should match category_discussion_path(@c1, d)
#  end

#  scenario "Create a new discussion when logged in" do
#    sign_in_user
#    visit discussions_path
#    click_link("New Discussion")

#    select @c1.name, :from => "discussion_category_id"
#    fill_in "Subject", :with => "I need help!"
#    fill_in "post_body", :with => "Please help me out. k thx."
#    click_button "Create"

#    d = Cornerstone::Discussion.find_by_subject("I need help!")
#    current_path.should match category_discussion_path(@c1, d)
#    page.should have_content(@user.name)
#  end

#  scenario "New discussion from within category view should have category pre-selected" do
#    visit discussions_category_path(@c1)
#    click_link ("New Discussion")
#    current_path.should match new_discussion_path
#    page.find("#discussion_category_id").value.should == @c1.id.to_s
#  end

#  scenario "Reply to an existing discussion when logged in" do
#    sign_in_user
#    discussion = Factory(:discussion_w_user, :user => @user)
#    reply1 = Factory(:post, :discussion => discussion,
#                            :name => "Reply Author",
#                            :email => "email@email.com")


#    visit category_discussion_path(discussion.category, discussion)
#    fill_in "post_body", :with => "Please help me out. k thx."
#    click_button "Comment"
#    current_path.should match category_discussion_path(discussion.category, discussion)
#    page.should have_content "Comment was successfully created."
#  end

#  scenario "Reply to an existing discussion when not logged in" do
#    discussion = Factory(:discussion_w_user)
#    reply1 = Factory(:post, :discussion => discussion,
#                            :name => "Reply Author",
#                            :email => "email@email.com")


#    visit category_discussion_path(discussion.category, discussion)
#    fill_in "Name", :with => "Anonymous"
#    fill_in "Email", :with => "anonymous@whatever.com"
#    fill_in "post_body", :with => "Please help me out. k thx."
#    click_button "Comment"
#    current_path.should match category_discussion_path(discussion.category, discussion)
#    page.should have_content "Comment was successfully created."
#  end
end
