class NewsletterMailer < ActionMailer::Base
  # default from: "#{ENV['FROM_NAME']} <#{ENV['FROM_EMAIL']}>"
  default from: "craig@gmail.com"
  add_template_helper(ApplicationHelper)

  # def mail_newsletter(contact_list, newsletter = Newsletter.current)
  #   @newsletter = newsletter
  #   @articles = @newsletter.articles_to_send.map { |article_id| Article.find(article_id) }
  #   puts "Sending emails."
  #   contact_emails = contact_list.map { |contact| contact.email }
  #   mail(
  #     to: ENV['FROM_EMAIL'],
  #     bcc: contact_emails,
  #     subject: "#{@newsletter.title} - #{@newsletter.newsletter_date}",
  #     template_name: 'newsletter'
  #   )
  # end

  def mail_newsletter(newsletter = Newsletter.current)
    @newsletter = newsletter
    @articles = @newsletter.articles_to_send.map { |article_id| Article.find(article_id) }
    puts "Sending emails."
    mail(
      to: "dcn@dcn.com",
      subject: "#{@newsletter.title} - #{@newsletter.newsletter_date}",
      template_name: 'newsletter'
    )
  end
end
