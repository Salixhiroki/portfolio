# frozen_string_literal: true

class Recipe < ApplicationRecord
  # validate :recipes_nothing
  with_options presence: true do
    validates :title
    validates :point
  end
  
 
  has_many :materials, dependent: :destroy
  has_many :cookmethods, dependent: :destroy

  has_many :favorites
  has_many :favorites_users, through: :favorites, source: 'user'

  has_many :comments, dependent: :destroy
  belongs_to :user

 
  def liked_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  mount_uploader :image, ImageUploader
  validates :image, presence: true
  accepts_nested_attributes_for :materials, allow_destroy: true,reject_if: :all_blank
  accepts_nested_attributes_for :cookmethods, allow_destroy: true,reject_if: :all_blank

  attr_accessor :content
   
end
