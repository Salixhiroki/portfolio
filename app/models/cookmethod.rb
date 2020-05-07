# frozen_string_literal: true

class Cookmethod < ApplicationRecord
  belongs_to :recipe, optional: true
  
  # include RankedModel
  # ranks :row_order, with_same: [:user_id, :recipe_id]
  
end
