require 'rails_helper'
require 'rake'

RSpec.describe 'create_newsletter.rake', vcr: true do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let!(:contacts) { FactoryGirl.create_list(:contact, 3) }

  before(:each) do
    load File.expand_path("../../../lib/tasks/create_newsletter.rake", __FILE__)
    load File.expand_path("../../../lib/tasks/run_mailer.rake", __FILE__)
    load File.expand_path("../../../lib/seeders/newsletter_feed_seeder.rb", __FILE__)
    Rake::Task.define_task(:environment)

    NewsletterFeedSeeder.seed_newsletter_feeds
  end

  describe 'create_newsletter' do
    it 'creates and sends the newsletter' do
      Rake::Task['create_newsletter'].invoke
      Rake::Task['run_mailer'].invoke

      expect(Newsletter.current.articles.count).to be > 0

      Newsletter.current.articles.each do |article|
        expect(article.article_date).to eq(Newsletter.current.newsletter_date)
      end

      contact_emails = contacts.map { |contact| contact.email }

      open_last_email
      expect(current_email).to bcc_to(contact_emails)

      Newsletter.current.articles.each do |article|
        expect(current_email).to have_body_text(article.title)
        expect(current_email).to have_body_text(article.url)
      end
    end
  end
end
