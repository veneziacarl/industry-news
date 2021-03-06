require 'rails_helper'

RSpec.describe NewsletterMailer do
  include EmailSpec::Matchers

  describe '#mail_newsletter', vcr: true do
    let(:contacts) { FactoryGirl.create_list(:contact, 3) }
    let(:newsletter) { FactoryGirl.create(:newsletter) }
    let!(:newsletter_articles) { FactoryGirl.create_list(:newsletter_article, 5, newsletter: newsletter) }
    let!(:newsletter_article_no_send) { FactoryGirl.create(:newsletter_article, :no_send, newsletter: newsletter) }
    let!(:email) { NewsletterMailer.mail_newsletter(contacts, newsletter).deliver_now }

    skip 'is from the correct email with a name' do
      expect(email).to have_header('From', "#{ENV['FROM_NAME']} <#{ENV['FROM_EMAIL']}>")
    end

    skip 'delivers to contact email' do
      expect(email).to deliver_to(ENV['FROM_EMAIL'])

      contact_emails = contacts.map { |contact| contact.email }
      expect(email).to bcc_to(contact_emails)
    end

    skip 'has a subject' do
      expect(email).to have_subject("#{newsletter.title} - #{newsletter.newsletter_date}")
    end

    skip 'has the correct email body with markdown' do
      expect(email).to have_body_text('newsletter description')
      expect(email.body).to have_selector('em', text: 'bold')

      newsletter.reload
      newsletter_articles.each do |newsletter_article|
        expect(email).to have_body_text(newsletter_article.article.title)
        expect(email).to have_body_text(newsletter_article.article.url)
        expect(email).to have_body_text(newsletter_article.article.description)
      end

      expect(email).to_not have_body_text(newsletter_article_no_send.article.title)
      expect(email).to_not have_body_text(newsletter_article_no_send.article.url)
      expect(email).to_not have_body_text(newsletter_article_no_send.article.description)
    end
  end
end
