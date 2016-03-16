FactoryGirl.define do
  factory :newsletter_article do
    newsletter
    article

    trait :no_send do
      send_article 'false'
    end
  end
end
