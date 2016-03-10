require 'uri'

class Article < ActiveRecord::Base
  include Helpers::UrlValidator

  has_many :newsletter_articles
  has_many :newsletters, through: :newsletter_articles
  belongs_to :newsletter_feed

  validates :article_date, presence: true
  validates :title, presence: true
  validates :url, presence: true
  validate :valid_url?
end
