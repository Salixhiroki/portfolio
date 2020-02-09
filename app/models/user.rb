class User < ApplicationRecord

  validates :name, presence: true, length: {maximum: 15}
  validates :email, presence: true
  validates :password, presence: true, length: {in: 8..32}
  validates :password_digest, presence: true
  
  
  
  
  has_secure_password

end
