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

ActiveRecord::Schema.define do

  create_table "boards", :force => true do |t|
    t.string   "title"
    t.string   "name",        :limit => 20
    t.integer  "posts_count",               :default => 0
    t.datetime "created_at"
    t.integer  "open_level",                :default => 99
  end

  add_index "boards", ["open_level"], :name => "index_boards_on_open_level"
  add_index "boards", ["name"], :name => "index_boards_on_name", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "name"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.boolean  "wiki",       :default => true
  end

  add_index "pages", ["name"], :name => "index_pages_on_name", :unique => true

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "board_id"
    t.integer  "user_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.boolean  "notice",                       :default => false
    t.boolean  "tmp",                          :default => false
    t.string   "ip",            :limit => 15
    t.integer  "parent_id"
    t.integer  "replies_count",                :default => 0
    t.string   "homepage",      :limit => 100
    t.string   "password"
    t.string   "visitor",       :limit => 20
  end

  add_index "posts", ["parent_id"], :name => "index_posts_on_parent_id"
  add_index "posts", ["board_id"], :name => "index_posts_on_board_id"

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
    t.boolean  "admin",                                    :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "viewings", :force => true do |t|
    t.integer  "viewer_id",   :limit => 11
    t.integer  "viewed_id",   :limit => 11
    t.string   "viewed_type", :limit => 20
    t.string   "ip",          :limit => 24
    t.datetime "created_at"
  end

  add_index "viewings", ["viewer_id"], :name => "index_viewings_on_viewer_id"
  add_index "viewings", ["viewed_type", "viewed_id"], :name => "index_viewings_on_viewed_type_and_viewed_id"

end
