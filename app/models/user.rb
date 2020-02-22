class User < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :email
    validates :password
    validates :password_digest
  end
  
  validates :name, length: {maximum: 15}
  validates :password, length: {in: 8..32}
  
  
  has_many :recipes
  
  
  has_secure_password
  
end
