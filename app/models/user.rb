class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :room_users
  has_many :rooms, through: :room_users

  enum role: { customer: 0, employee: 1 }

  with_options presence: true do
    validates :username, uniqueness: true
    validates :position
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は半角数字のみでご入力ください' }

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字でご入力ください' } do
      validates :last_name
      validates :first_name
    end
  end

  validate :phone_number_length_and_format

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合かつ6字以上でご入力ください' }

  def full_name
    "#{last_name} #{first_name}"
  end

  private

  def phone_number_length_and_format
    return unless phone_number.present?

    if phone_number.to_s.length < 10
      errors.add(:phone_number, 'is too short')
    elsif !phone_number.to_s.match(/\A\d{10,11}\z/)
      errors.add(:phone_number, 'は半角数字のみでご入力ください')
    end
  end
end
