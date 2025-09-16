class AddNameToCutYields < ActiveRecord::Migration[8.0]
  def change
    add_column :cut_yields, :name, :string
  end
end
