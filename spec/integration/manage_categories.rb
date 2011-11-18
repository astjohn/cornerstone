require 'spec_helper'

feature "Manage Categories" do

  background do
    sign_in_admin
  end

  scenario "Categories are listed with action buttons" do
    Factory(:category, :name => "General Help",
                       :category_type => "Discussion")
    Factory(:category, :name => "FAQs",
                       :category_type => "Article")
    visit admin_categories_path
    page.should have_content("General Help")
    page.should have_content("FAQs")
    page.should have_link("Edit")
    page.should have_link("Destroy")
    page.should have_link("New Category", :href => new_admin_category_path)
  end

  scenario "Create a new category successfully" do
    visit new_admin_category_path

    fill_in "Name", :with => "name 1"
    select "Discussion", :from => "category_type"
    fill_in "Description", :with => "some description"
    click_button "Create"

    current_path.should match admin_categories_path
    page.should have_content("name 1")
# TODO: flash in admin namespace
#    page.should have_content("Category created successfully.")
  end

  scenario "Update a category successfully" do
    category = Factory(:category, :name => "FAQs",
                       :category_type => "Article")
    visit admin_categories_path
    click_link "Edit"
    current_path.should match edit_admin_category_path(category)
    fill_in "Name", :with => "Different Name"
    click_button "Update"

    current_path.should match admin_categories_path
    page.should have_content("Different Name")
  end

  scenario "Delete a category" do
    Factory(:category, :name => "General Help",
                       :category_type => "Discussion")
    Factory(:category, :name => "Other Help",
                       :category_type => "Discussion")
    Factory(:category, :name => "FAQs",
                       :category_type => "Article")
    visit admin_categories_path
    within("table#discussion_categories tr:last-child") do
      click_link "Destroy"
    end
    current_path.should match admin_categories_path
    page.should_not have_content("Other Help")
  end

end
