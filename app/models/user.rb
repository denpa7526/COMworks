class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  def full_name
    "#{last_name} #{first_name}"
  end

  # def employee?
    # role == 1
  # end

end
