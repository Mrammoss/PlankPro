class RemoveProjectIdFromMiterFrames < ActiveRecord::Migration[8.0]
  def change
    remove_column :miter_frames, :project_id, :bigint
  end
end
