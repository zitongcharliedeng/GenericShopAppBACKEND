class User < ApplicationRecord
  has_many :orders
  has_one :session
  has_secure_password
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
