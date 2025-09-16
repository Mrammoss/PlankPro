class RemoveProjectIdFromCutYields < ActiveRecord::Migration[8.0]
  def change
    remove_column :cut_yields, :project_id, :bigint
  end
end
