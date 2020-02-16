class Recipe < ApplicationRecord

 validate :recipes_nothing
 
  has_many :materials
  has_many :cookmethods
  has_many :user
  
  accepts_nested_attributes_for :materials 
  accepts_nested_attributes_for :cookmethods
  
 
   def recipes_nothing
     
     
     
   end

end
