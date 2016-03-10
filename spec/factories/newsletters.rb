FactoryGirl.define do
  factory :newsletter do
    sequence(:newsletter_date) { |n| Date.new(2016,2,20) - n }
    title 'this is the title'
    description 'descript'
  end
end
