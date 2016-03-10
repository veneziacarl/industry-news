require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should have_many(:newsletter_articles) }
  it { should have_many(:newsletters) }

  it { should validate_presence_of(:article_date) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }

  it { should have_valid(:url).when('http://www.google.com', 'https://www.google.com', 'https://sports.yahoo.com', 'https://sports.yahoo.com/nba', 'https://asdf.abc') }
  it { should_not have_valid(:url).when(nil, '', 'us', 'us@com') }
end
