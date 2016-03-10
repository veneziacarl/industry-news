require 'rails_helper'

RSpec.describe NewsletterFeed, type: :model do
  it { should validate_presence_of(:feed_name) }
  it { should validate_presence_of(:url) }

  it { should have_valid(:url).when('http://www.google.com', 'https://www.google.com', 'https://sports.yahoo.com', 'https://sports.yahoo.com/nba', 'https://asdf.abc') }
  it { should_not have_valid(:url).when(nil, '', 'us', 'us@com') }
end
