FactoryGirl.define do
  factory :user do
    first_name "First"
    last_name "Last"
    sequence(:email) { |n| "user#{n}@test.com" }
    password "strongpassword"

    trait :admin do
      role 'admin'
    end
  end
end
