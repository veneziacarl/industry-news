class AddDailyAndWeeklyOptsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :daily_news, :boolean, null: false, default: 'true'
    add_column :contacts, :weekly_news, :boolean, null: false, default: 'true'
  end
end
