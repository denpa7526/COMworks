class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :username, null: false
      t.string :position, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false, default: ""
      t.integer :role, null: false, default: 0

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
