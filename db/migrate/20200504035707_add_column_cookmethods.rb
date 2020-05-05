class AddColumnCookmethods < ActiveRecord::Migration[5.2]
  def change
    add_column :cookmethods, :row_order, :integer
  end
end
