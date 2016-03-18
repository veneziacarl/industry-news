class MailchimpSubscribeJob
  include SuckerPunch::Job

  def perform(contact)
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.create(body: { email_address: contact.email, status: 'subscribed' })
  end
end
