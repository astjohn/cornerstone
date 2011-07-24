Factory.sequence :email do |n|
  "email#{n}@example.com"
end

FactoryGirl.define do

  factory :discussion, :class => Cornerstone::Discussion do
    name "Joe Blow"
    #email { Factory.create(:email) }
    email "jb@gmail.com"
  end

end

