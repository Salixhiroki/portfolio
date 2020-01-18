class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :title
      t.string :material_name
      t.string :material_quantity
      t.string :recipe
      t.string :point
      t.string :image
      t.string :impression
      
      t.timestamps
    end
  end
end
