class CreateAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_users do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :username, null: false
      t.string :company, null: false
      t.string :phone_number, null: false
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.timestamps
    end

    add_index :admin_users, :username, unique: true
    add_index :admin_users, :company,  unique: true
    add_index :admin_users, :email,    unique: true
  end
end
