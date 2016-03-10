class AddNewsletterFeedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :newsletter_feed_id, :integer, null: false
  end
end
