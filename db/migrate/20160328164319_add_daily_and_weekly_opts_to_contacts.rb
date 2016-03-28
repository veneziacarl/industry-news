class AddDailyAndWeeklyOptsToContacts < ActiveRecord::Migration
  def up
    add_column :contacts, :daily_news, :boolean, null: false, default: 'true'
    add_column :contacts, :weekly_news, :boolean, null: false, default: 'true'
    Contact.find_each do |contact|
      contact.daily_news = true
      contact.weekly_news = true
    end
  end

  def down
    remove_column :contacts, :daily_news
    remove_column :contacts, :weekly_news
  end
end
