class Recipe < ApplicationRecord

 validate :recipes_nothing
 
  has_many :materials,dependent: :destroy
  has_many :cookmethods,dependent: :destroy
  
  has_many :favorites
  has_many :favorites_users,through: :favorites, source: 'user'
  
  has_many :comments
  belongs_to :user
  
  
  accepts_nested_attributes_for :materials, allow_destroy: true
  accepts_nested_attributes_for :cookmethods, allow_destroy: true
  
 attr_accessor :content
 
 
  
 
 
 
   def recipes_nothing
     
     
     
   end

end
