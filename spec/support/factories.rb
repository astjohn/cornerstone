Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.sequence :category_name do |n|
  "Category - #{n}"
end

FactoryGirl.define do

  factory :discussion, :class => Cornerstone::Discussion do
    subject "Help please"
    body "I can't figure this out.  What do I do next?"
    category
  end

  factory :discussion_no_user, :parent => :discussion do
    name "Joe Blow"
    email { Factory.next(:email) }
  end

  factory :discussion_w_user, :parent => :discussion do
    user
  end

  factory :user do
    name "Alice Mcduffry"
    email { Factory.next(:email) }
    password "tester"
    encrypted_password "$2a$10$5JwEZ3gf0udh3MRlNYQP3Ow3fAsw/jFJZA4tKMB760wC.Uv7w7jJi"
  end

  factory :category, :class => Cornerstone::Category do
    name { Factory.next(:category_name) }
    category_type Cornerstone::Category::TYPES.first
    item_count 4
  end

end

