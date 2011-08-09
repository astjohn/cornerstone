Given /^the following categories:$/ do |table|
  table.hashes.each do |attributes|
    Factory.create(:category, attributes)
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) category$/ do |pos|
  visit path_to "the categories page"
  within("table tr:nth-child(#{pos.to_i-1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following categories:$/ do |table|
  table.hashes.each do |attributes|
    attributes.each do |attr|
      steps %Q{
        Then I should see "#{attr[1]}"
      }
    end
  end
end

