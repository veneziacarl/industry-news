class Contact < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: Devise::email_regexp, message: 'invalid email format'
end
