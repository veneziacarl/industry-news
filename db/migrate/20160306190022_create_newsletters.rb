class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.date :newsletter_date, null: false
      t.string :title, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
