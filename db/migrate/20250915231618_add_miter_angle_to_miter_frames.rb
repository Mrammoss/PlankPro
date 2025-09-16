class AddMiterAngleToMiterFrames < ActiveRecord::Migration[8.0]
  def change
    add_column :miter_frames, :miter_angle, :float
  end
end
