require 'spec_helper'

feature "Manage Articles" do

  background do
    sign_in_admin
  end

  scenario "Articles are listed with action buttons" do
    Factory(:article, :title => "General Help")
    Factory(:article, :title => "How to ask for help")
    visit admin_articles_path
    page.should have_content("General Help")
    page.should have_content("How to ask for help")
    page.should have_link("Edit")
    page.should have_link("Destroy")
    page.should have_link("New Article", :href => new_admin_article_path)
  end

  scenario "Create a new article successfully" do
    Factory(:category, :name => "FAQs",
                       :category_type => "Article")
    visit new_admin_article_path

    fill_in "Title", :with => "name 1"
    select "FAQs", :from => "article_category_id"
    fill_in "Body", :with => "some article body"
    click_button "Create"

    page.should have_content("name 1")
    page.should have_content("some article body")
# TODO: flash in admin namespace
#    page.should have_content("Article created successfully.")
  end

  scenario "Update an article successfully" do
    article = Factory(:article, :title => "whatever")
    visit admin_articles_path
    click_link "Edit"
    current_path.should match edit_admin_article_path(article)
    fill_in "Title", :with => "Different Title"
    click_button "Update"

    page.should have_content("Different Title")
  end

  scenario "Delete an Article" do
    Factory(:article, :title => "One")
    Factory(:article, :title => "Two")
    Factory(:article, :title => "Three")
    visit admin_articles_path
    within("table#articles tr:last-child") do
      click_link "Destroy"
    end
    current_path.should match admin_articles_path
    page.should_not have_content("Three")
  end

end
