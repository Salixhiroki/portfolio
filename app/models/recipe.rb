class Recipe < ApplicationRecord

 validate :recipes_nothing
 
  has_many :materials
  has_many :user
  
  accepts_nested_attributes_for :materials
 
   def recipes_nothing
     
     
     
   end

end
