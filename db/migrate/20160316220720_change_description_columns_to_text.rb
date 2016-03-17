class ChangeDescriptionColumnsToText < ActiveRecord::Migration
  def change
    remove_column :articles, :description, :string
    remove_column :newsletters, :description, :string

    add_column :articles, :description, :text
    add_column :newsletters, :description, :text
  end
end
