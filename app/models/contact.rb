class Contact < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: Devise::email_regexp, message: 'invalid email format'
  validates :daily_news, presence: true
  validates :weekly_news, presence: true

  after_commit :unsubscribe_to_mailchimp, on: :destroy
  after_commit :subscribe_to_mailchimp, on: :create

  private

  def subscribe_to_mailchimp
    MailchimpSubscribeJob.perform_async(self)
  end

  def unsubscribe_to_mailchimp
    MailchimpUnsubscribeJob.perform_async(self)
  end
end
