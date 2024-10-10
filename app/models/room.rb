class Room < ApplicationRecord

  belongs_to :created_by, class_name: 'User'
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users

  enum room_type: { private_room: 0, public_room: 1 }

  validates :name, presence: true

  after_validation :log_errors, if: -> { errors.any? }

  private

  def log_errors
    Rails.logger.debug errors.full_messages.join(", ")
  end

end
