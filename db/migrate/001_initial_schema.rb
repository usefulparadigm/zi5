class InitialSchema < ActiveRecord::Migration
  def self.up
  
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
      t.column :admin, :boolean, :default => false
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
      t.integer :parent_id
      t.integer :replies_count, :default => 0
      t.string :visitor, :limit => 20
      t.string :homepage, :limit => 100
      t.string :password
    end
    add_index :posts, :board_id
    add_index :posts, :parent_id
  
    create_table "boards", :force => true do |t|
      t.string :title
      t.string :name, :limit => 20
      t.integer :posts_count, :default => 0
      t.datetime :created_at
      t.integer :open_level, :default => 99   end
    add_index :boards, :name, :unique => true 
    add_index :boards, :open_level
  
    create_table "pages", :force => true do |t|
      t.string :title, :name
      t.text :body
      t.integer :user_id
      t.datetime :created_at, :updated_at
      t.boolean :wiki, :default => true
    end
    add_index :pages, :name, :unique => true 
  
    
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

  def self.down
    drop_table :users
    drop_table :viewings
    drop_table :pages
    drop_table :posts
    drop_table :boards
  end
end
