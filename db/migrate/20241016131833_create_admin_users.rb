class CreateAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_users do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :phone_number,    null: false
      t.string :email,           null: false, default: ""
      t.string :password_digest, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :admin_users, :email,    unique: true
  end
end
