class AdminUser < ApplicationRecord
  has_secure_password
  belongs_to :user
  belongs_to :company

  attr_accessor :admin_code
  validates :admin_code, presence: true, on: :create
  validate :valid_admin_code, on: :create

  with_options presence: true do
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10～11桁の半角数字でご入力ください' }
    validates :password_digest, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/, message: 'は半角英数字混合かつ6字以上でご入力ください' }

    with_options uniqueness: true do
      validates :username
      validates :company
      validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must contain @" }
    end

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字でご入力ください' } do
      validates :last_name
      validates :first_name
    end
  end

  def full_name
    "#{last_name} #{first_name}"
  end
  
  private

  def valid_admin_code
    correct_code = Rails.env.production? ? ENV['SECRET_ADMIN_CODE'] : 'development_admin_code'
    unless admin_code == correct_code
      errors.add(:admin_code, 'が正しくありません')
    end
  end

end
