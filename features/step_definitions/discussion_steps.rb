When /^I delete the (\d+)(?:st|nd|rd|th) discussion$/ do |pos|
  visit path_to "the discussions page"
  within("table tr:nth-child(#{pos.to_i-1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following discussions:$/ do |table|
  table.hashes.each do |attributes|
    attributes.each do |attr|
      steps %Q{
        Then I should see "#{attr[1]}"
      }
    end
  end
end


Then /^I should see the "([^"]*)" of the discussion$/ do |attr|
  d = model('discussion')
  Then "I should see \"#{d.send(attr.to_sym)}\""
end

#Given /^I enter a new discussion in the form$/ do
#  steps %Q{
#    When I select "Category - 1" from "discussion_category_id"
#    And I fill in the following:
#      | Subject                                  | I need help!               |
#      | Name                                     | Waffles                    |
#      | Email                                    | w@ihop.com                 |
#      | discussion[posts_attributes][0][body]    | Please help me out. k thx. |
#    And I press "Create"
#    Then I should be on "the discussion page for 'I need help!'"
#  }
#end

