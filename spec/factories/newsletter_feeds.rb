FactoryGirl.define do
  factory :newsletter_feed do
    sequence(:feed_name) { |n| "feed name #{n}" }
    url 'http://www.test.com'
  end
end
