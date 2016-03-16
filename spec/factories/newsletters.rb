FactoryGirl.define do
  factory :newsletter do
    sequence(:newsletter_date) { |n| Date.new(2016,2,20) - n }
    sequence(:title) { |n| "this is the title #{n}" }
    sequence(:description) { |n| "newsletter description *bold* #{n}" }
  end
end
