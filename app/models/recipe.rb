class Recipe < ApplicationRecord

 validate :recipes_nothing
 
  has_many :materials
  has_many :cookmethods
  belongs_to :user
  
  accepts_nested_attributes_for :materials 
  accepts_nested_attributes_for :cookmethods
  
 
 
 
  
 
 
 
   def recipes_nothing
     
     
     
   end

end
