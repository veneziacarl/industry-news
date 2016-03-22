# Previews: http://localhost:3000/rails/mailers/newsletter/newsletter_preview
class NewsletterPreview < ActionMailer::Preview
  def newsletter_preview
    NewsletterMailer.mail_newsletter()
  end
end
