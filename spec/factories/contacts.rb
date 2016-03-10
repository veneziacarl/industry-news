FactoryGirl.define do
  factory :contact do
    sequence(:email) { |n| "contact#{n}@test.com" }
  end
end
