Factory.sequence :email do |n|
  "email#{n}@example.com"
end

FactoryGirl.define do

  factory :discussion, :class => Cornerstone::Discussion do
    name "Joe Blow"
    email { Factory.next(:email) }
  end

  factory :user do
    name "Alice Mcduffry"
    email { Factory.next(:email) }
    password "tester"
    encrypted_password "$2a$10$5JwEZ3gf0udh3MRlNYQP3Ow3fAsw/jFJZA4tKMB760wC.Uv7w7jJi"
  end


end

