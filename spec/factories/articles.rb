FactoryGirl.define do
  factory :article do
    article_date Date.today
    sequence(:title) { |n| "article title #{n}" }
    url 'http://www.test.com'
    description 'article descript'
    newsletter_feed
  end
end
