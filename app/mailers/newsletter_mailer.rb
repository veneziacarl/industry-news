class NewsletterMailer < ActionMailer::Base
  default from: "#{ENV['FROM_NAME']} <#{ENV['FROM_EMAIL']}>"

  def mail_newsletter(contact_list, newsletter = Newsletter.current)
    @newsletter = newsletter
    puts "Sending emails."
    contact_emails = contact_list.map { |contact| contact.email }
    mail(
      to: ENV['FROM_EMAIL'],
      bcc: contact_emails,
      subject: "#{@newsletter.title} - #{@newsletter.newsletter_date}",
      template_name: 'newsletter'
    )
  end
end
