class User < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :email
    validates :password
    validates :password_digest
  end
  
  validates :name, length: {maximum: 15}
  validates :password, length: {in: 8..32}
  
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX  }
  
  
  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  
  has_many :recipes, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :favorites_recipes,through: :favorites, source: 'recipe', :dependent => :destroy
  has_many :comments
  
  mount_uploader :user_image,ImageUploader
  
  has_secure_password
  
end
