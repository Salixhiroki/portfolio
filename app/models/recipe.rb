class Recipe < ApplicationRecord

 validate :recipes_nothing
 
  def recipes_nothing
    :recipes.each do |recipe|
    
    if recipe=nil?
    end
  end
    
  end

end
