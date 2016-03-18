class MailchimpUnsubscribeJob
  include SuckerPunch::Job

  def perform(contact)
    md5 = Digest::MD5.new
    md5.update contact.email.downcase
    md5_hash = md5.hexdigest

    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members(md5_hash).update(body: { status: 'unsubscribed' })
  end
end
