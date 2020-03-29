# frozen_string_literal: true

class User < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :email
    validates :password, on: :create
    validates :password_digest, on: :create
  end

  validates :name, length: { maximum: 15 }
  # validates :password, length: {in: 8..32}

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }, on: :create

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, format: { with: VALID_EMAIL_REGEX }

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_recipes, through: :favorites, source: 'recipe', dependent: :destroy
  has_many :comments

  mount_uploader :user_image, ImageUploader

  has_secure_password
end
