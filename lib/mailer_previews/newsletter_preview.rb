# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class NewsletterPreview < ActionMailer::Preview
  def newsletter_preview
    NewsletterMailer.mail_newsletter()
  end
end
