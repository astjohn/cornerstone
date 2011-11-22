require 'spec_helper'

feature "Manage Articles" do

  before do
    visit root_url
  end

  scenario "Visit the home page" do
    page.should have_content("Browse Discussions")
    page.should have_content("Browse Knowledge Base")
  end

  scenario "Browse discussions" do
    click_link "Browse Discussions"
    current_path.should match discussions_path
  end

  scenario "Browse knowledge base" do
    click_link "Browse Knowledge Base"
    current_path.should match knowledge_base_path
  end


end
