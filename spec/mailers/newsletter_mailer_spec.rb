require 'rails_helper'

RSpec.describe NewsletterMailer do
  include EmailSpec::Matchers

  describe '#mail_newsletter' do
    let(:contacts) { FactoryGirl.create_list(:contact, 3) }
    let(:newsletter) { FactoryGirl.create(:newsletter) }
    let!(:newsletter_articles) { FactoryGirl.create_list(:newsletter_article, 5, newsletter: newsletter) }
    let!(:email) { NewsletterMailer.mail_newsletter(contacts, newsletter).deliver_now }

    it 'is from the correct email with a name' do
      expect(email).to have_header('From', "#{ENV['FROM_NAME']} <#{ENV['FROM_EMAIL']}>")
    end

    it 'it delivers to contact email' do
      expect(email).to deliver_to(ENV['FROM_EMAIL'])

      contact_emails = contacts.map { |contact| contact.email }
      expect(email).to bcc_to(contact_emails)
    end

    it 'has a subject' do
      expect(email).to have_subject("#{newsletter.title} - #{newsletter.newsletter_date}")
    end

    it 'has the correct email body' do
      expect(email).to have_body_text(newsletter.description)

      newsletter.reload
      newsletter_articles.each do |newsletter_article|
        expect(email).to have_body_text(newsletter_article.article.title)
        expect(email).to have_body_text(newsletter_article.article.url)
        expect(email).to have_body_text(newsletter_article.article.description)
      end
    end
  end
end
