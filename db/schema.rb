ActiveRecord::Schema.define do

  create_table "users", :force => true do |t|
    t.column :login,                     :string, :limit => 40
    t.column :name,                      :string, :limit => 100, :default => '', :null => true
    t.column :email,                     :string, :limit => 100
    t.column :crypted_password,          :string, :limit => 40
    t.column :salt,                      :string, :limit => 40
    t.column :created_at,                :datetime
    t.column :updated_at,                :datetime
    t.column :remember_token,            :string, :limit => 40
    t.column :remember_token_expires_at, :datetime
  end

  add_index :users, :login, :unique => true

  create_table "posts", :force => true do |t|
    t.string :title
    t.text :body
    t.integer :board_id
    t.integer :user_id
    t.string :ip, :limit => 15
    t.datetime :created_at, :updated_at
    t.boolean :notice, :default => false
    t.boolean :tmp, :default => false
  end
  add_index :posts, :board_id

  create_table "boards", :force => true do |t|
    t.string :title, :name
    t.integer :posts_count, :default => 0
    t.datetime :created_at
    t.boolean :public, :default => true
  end
  add_index :boards, :name, :unique => true 

  create_table "pages", :force => true do |t|
    t.string :title, :name
    t.text :body
    t.integer :user_id
    t.datetime :created_at, :updated_at
  end
  add_index :pages, :name, :unique => true 

  # for acts-as-vewed

  create_table "viewings", :force => true do |t|
    t.integer  "viewer_id",   :limit => 11
    t.integer  "viewed_id",   :limit => 11
    t.string   "viewed_type", :limit => 20
    t.string   "ip",          :limit => 24
    t.datetime "created_at"
  end

  add_index "viewings", ["viewed_type", "viewed_id"], :name => "index_viewings_on_viewed_type_and_viewed_id"
  add_index "viewings", ["viewer_id"], :name => "index_viewings_on_viewer_id"

end