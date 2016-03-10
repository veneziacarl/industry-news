class DeleteNewsletterArticles < ActiveRecord::Migration
  def up
    drop_table :newsletter_articles
  end

  def down
    create_table :newsletter_articles do |t|
      t.integer :newsletter_id, null: false
      t.integer :article_id, null: false
      t.string :send, null: false, default: 'true'

      t.timestamps null: false
    end
  end
end
