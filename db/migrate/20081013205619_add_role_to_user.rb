class AddRoleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :role
    remove_column :users, :admin
  end
end
