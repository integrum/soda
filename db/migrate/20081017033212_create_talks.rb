class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.integer :user_id, :meeting_id, :upload_id
      t.string :name
      t.text :abstract_description, :external_embed  
      t.timestamps
    end
  end

  def self.down
    drop_table :talks
  end
end
