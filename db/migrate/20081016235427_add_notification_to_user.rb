class AddNotificationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :send_emails, :boolean, :default => true
  end

  def self.down
    remove_column :users, :send_emails
  end
end
