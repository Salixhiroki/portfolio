class Material < ApplicationRecord

  
  belongs_to :recipe, optional: true


end


# "recipe"=>
#   {"title"=>"sjaos",
#   "material"=>{"material_name"=>["sjais", "dsjo", ""], "material_quantity"=>["idjso", "djso", ""]},
#   "cookmethod"=>{"method"=>["sajo", "ijsdo", "djsoi", ""]},
#   "point"=>"sjaijsa",
#   "impression"=>"saij"},