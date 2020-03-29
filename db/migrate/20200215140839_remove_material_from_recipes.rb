# frozen_string_literal: true

class RemoveMaterialFromRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :material_name, :text
    remove_column :recipes, :material_quantity, :text
    remove_column :recipes, :recipe, :text
  end
end
