desc 'mail the daily newsletter'
task run_mailer: :environment do
  NewsletterMailer.mail_newsletter(Contact.all, Newsletter.current).deliver_now
end
