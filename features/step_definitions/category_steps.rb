When /^I delete the (\d+)(?:st|nd|rd|th) category$/ do |pos|
  visit path_to "the categories page"
  within("table tr:nth-child(#{pos.to_i-1})") do
    click_link "Destroy"
  end
end

