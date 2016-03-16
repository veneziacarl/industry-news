FactoryGirl.define do
  factory :article do
    article_date Date.today
    sequence(:title) { |n| "article title #{n}" }
    sequence(:url) { |n| "http://www.test#{n}.com" }
    sequence(:description) { |n| "article description #{n}" }
    newsletter_feed
  end
end
