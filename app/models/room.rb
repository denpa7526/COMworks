class Room < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users

  enum room_type: { private_room: 0, public_room: 1 }
  
end
