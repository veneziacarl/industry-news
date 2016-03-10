class CreateNewsletterFeeds < ActiveRecord::Migration
  def change
    create_table :newsletter_feeds do |t|
      t.string :feed_name, null: false
      t.string :url, null: false

      t.timestamps null: false
    end
  end
end
