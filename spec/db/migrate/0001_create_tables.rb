class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false, :default => ""
      t.integer :sign_in_count, :null => false, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip, :limit => 40
      t.string :last_sign_in_ip, :limit => 40
      t.timestamps
    end
    add_index :users, :email, :unique => true

    create_table :profiles do |t|
      t.integer :user_id, :null => false
      t.string :first_name, :null => false, :default => "", :limit => 80
      t.string :last_name, :null => false, :default => "", :limit => 80
      t.text :bio
      t.date :dob
      t.timestamps
    end
    add_index :profiles, :user_id, :unique => true

    create_table :projects do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false, :default => "", :limit => 150
      t.integer :status, :null => false, :limit => 1, :default => 1
      t.boolean :is_private, :null => false, :default => true
      t.timestamps
    end
    add_index :projects, :user_id
  end
end
