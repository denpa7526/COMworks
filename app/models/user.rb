class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :shared_password
  has_one :admin_user
  belongs_to :company, optional: true

  enum role: { customer: 0, employee: 1 }

  with_options presence: true do
    validates :username, uniqueness: true
    validates :position
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10～11桁の半角数字でご入力ください' }

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字でご入力ください' } do
      validates :last_name
      validates :first_name
    end
  end

  PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/
  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英数字混合かつ6字以上でご入力ください' }, if: -> { new_record? || !password.nil? }

  validate :check_shared_password, if: :employee?
  validate :check_company, if: :employee?

  def full_name
    "#{last_name} #{first_name}"
  end

  private

  def check_shared_password
    return if persisted? && !shared_password.present?

    if company.nil?
      errors.add(:company, "を入力してください")
      return
    end

    company_shared_password = company.shared_password
    
    is_valid = if company_shared_password
                 company_shared_password.authenticate(shared_password)
               else
                 SharedPassword.valid_initial_password?(shared_password)
               end

    errors.add(:shared_password, "が無効です") unless is_valid
  end

  def check_company
    errors.add(:company, "を入力してください") if company.blank?
  end
  
end