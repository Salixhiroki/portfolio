class CreateCookmethods < ActiveRecord::Migration[5.2]
  def change
    create_table :cookmethods do |t|

      t.integer :user_id
      t.integer :recipe_id
      t.string :method
      t.timestamps
    end
  end
end
