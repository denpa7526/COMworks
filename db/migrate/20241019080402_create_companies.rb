class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :companies, :name, unique: true

    add_reference :users, :company, foreign_key: true
    add_reference :admin_users, :company, foreign_key: true
    add_reference :shared_passwords, :company, foreign_key: true
  end
end
