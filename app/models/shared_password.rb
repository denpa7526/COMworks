class SharedPassword < ApplicationRecord
  has_secure_password
  belongs_to :company

  validates :password, presence: true, length: { minimum: 8 },
    format: { with: /\A(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!\"#$%&'()\-\^\\@\[;:,\.\/=~\|\`\{\+\*}\<>?_]]).{8,}\z/,
              message: 'は、それぞれ少なくとも1つの英大文字、英小文字、数字、記号を含み、8字以上でなければなりません'
  }

  def self.valid_initial_password?(password)
    initial_password = ENV['INITIAL_SHARED_PASSWORD']
    password == initial_password
  end

end
