Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.sequence :category_name do |n|
  "Category - #{n}"
end

FactoryGirl.define do

  factory :discussion, :class => Cornerstone::Discussion do
    subject "Help please"
    status Cornerstone::Discussion::STATUS.first
    category
  end

  factory :discussion_no_user, :parent => :discussion do |discussion|
    discussion.after_build { |d| Factory(:post_no_user, :discussion => d) }
  end

  factory :discussion_w_user, :parent => :discussion do |discussion|
    user
    discussion.after_build { |d| Factory(:post_w_user, :discussion => d,
                                                       :user => d.user) }
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
    description "Description for category."
    item_count 4
  end

  factory :post, :class => Cornerstone::Post do
    body "This is a post"
    discussion
  end

  factory :post_no_user, :parent => :post do
    name "Joe Blow"
    email { Factory.next(:email) }
  end

  factory :post_w_user, :parent => :post do
    user
  end

  factory :article, :class => Cornerstone::Article do
    title "How to Create a Widget"
    body "Step 1: bla bla"
    category
  end

end

