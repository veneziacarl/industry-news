class NewsletterFeed < ActiveRecord::Base
  include Helpers::UrlValidator

  has_many :articles
  
  validates :feed_name, presence: true
  validates :url, presence: true
  validate :valid_url?
end
