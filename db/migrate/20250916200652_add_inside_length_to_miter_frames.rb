class AddInsideLengthToMiterFrames < ActiveRecord::Migration[8.0]
  def change
    add_column :miter_frames, :inside_length, :decimal
  end
end
