class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.date :article_date, null: false
      t.string :title, null: false
      t.string :url, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
