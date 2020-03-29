# frozen_string_literal: true

class ChangeDatatypeMaterialNameAndMaterialQuantityAndRecipeOfRecipes < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :material_name, :text
    change_column :recipes, :material_quantity, :text
    change_column :recipes, :recipe, :text
  end
end
