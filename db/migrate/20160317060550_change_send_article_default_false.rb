class ChangeSendArticleDefaultFalse < ActiveRecord::Migration
  def change
    remove_column :newsletter_articles, :send_article, :string, null: false, default: 'true'

    add_column :newsletter_articles, :send_article, :string, null: false, default: 'false'
  end
end
