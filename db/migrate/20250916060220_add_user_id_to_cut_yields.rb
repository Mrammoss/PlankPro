class AddUserIdToCutYields < ActiveRecord::Migration[8.0]
  def change
    add_reference :cut_yields, :user, null: false, foreign_key: true
  end
end
