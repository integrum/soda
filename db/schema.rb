# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081019232410) do

  create_table "meetings", :force => true do |t|
    t.string   "title"
    t.string   "location"
    t.text     "description"
    t.datetime "occurs_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsvps", :force => true do |t|
    t.integer  "user_id"
    t.integer  "meeting_id"
    t.boolean  "present",    :default => false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "talks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "meeting_id"
    t.integer  "upload_id"
    t.string   "name"
    t.text     "external_embed"
    t.text     "abstract_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", :force => true do |t|
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "role"
    t.boolean  "admin",                                    :default => false
    t.boolean  "send_emails",                              :default => true
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "wiki_pages", :force => true do |t|
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
