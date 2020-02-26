class Recipe < ApplicationRecord

 validate :recipes_nothing
 
  has_many :materials
  has_many :cookmethods
  belongs_to :user
  
  accepts_nested_attributes_for :materials, allow_destroy: true
  accepts_nested_attributes_for :cookmethods, allow_destroy: true
  
 
 
 
  
 
 
 
   def recipes_nothing
     
     
     
   end

end
