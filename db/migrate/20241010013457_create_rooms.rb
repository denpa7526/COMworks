class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name,           null: false
      t.integer :room_type,     null: false, default: 0  #room_type: 0 = 社内用, 1 = 社外用
      t.references :created_by, null: false, foreign_key: { to_table: :users }  #ルーム作成者（ユーザーID）
      t.timestamps
    end
  end
end
