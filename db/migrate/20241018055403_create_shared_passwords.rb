class CreateSharedPasswords < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_passwords do |t|
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :shared_passwords, :password_digest, unique: true
  end
end
