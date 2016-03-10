require 'rails_helper'

RSpec.describe NewsletterArticle, type: :model do
  it { should belong_to(:newsletter) }
  it { should belong_to(:article) }

  # it { should validate_presence_of(:newsletter) }
  # it { should validate_presence_of(:article) }
  # it { should validate_presence_of(:send_article) }

  # newsletter = FactoryGirl.create(:newsletter)
  # article = FactoryGirl.create(:article)
  # subject { NewsletterArticle.new(newsletter: newsletter, article: article, send: 'true')}
  # it { should validate_uniqueness_of(:newsletter).scoped_to(:article) }
end
