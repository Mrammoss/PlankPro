class AddShapeTypeToMiterFrames < ActiveRecord::Migration[8.0]
  def change
    add_column :miter_frames, :shape_type, :string
  end
end
