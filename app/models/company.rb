class Company < ApplicationRecord
  has_many :users
  has_many :admin_users
  has_one :shared_password

  validates :name, presence: true, uniqueness: true
end
