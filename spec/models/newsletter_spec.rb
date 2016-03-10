require 'rails_helper'

RSpec.describe Newsletter, type: :model do
  let!(:newsletters) { FactoryGirl.create_list(:newsletter, 4)}
  let!(:current_newsletter) { FactoryGirl.create(:newsletter, newsletter_date: Date.today)}

  it { should have_many(:newsletter_articles) }
  it { should have_many(:articles) }

  it { should validate_presence_of(:newsletter_date) }
  it { should validate_presence_of(:title) }

  subject { FactoryGirl.build(:newsletter) }
  it { should validate_uniqueness_of(:newsletter_date) }

  it '#current should return the most recent newsletter' do
    expect(Newsletter.current).to eq(current_newsletter)
  end
end
