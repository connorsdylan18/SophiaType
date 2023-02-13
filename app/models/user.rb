class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email adress"}
  validates :password, presence: true
  validates :password, format: { with: /[A-Z]/, message: "must include one uppercase letter"}
  validates :password, format: { with: /\d/, message: "must include one number"}
  validates :password, length: { minimum: 8, message: "must be at least 8 characters long"}
end
