class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true
  validates :email_address, uniqueness: true

  has_many :orders, dependent: :destroy
  
end
