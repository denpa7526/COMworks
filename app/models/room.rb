class Room < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
end
