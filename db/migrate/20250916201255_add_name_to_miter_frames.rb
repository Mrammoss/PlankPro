class AddNameToMiterFrames < ActiveRecord::Migration[8.0]
  def change
    add_column :miter_frames, :name, :string
  end
end
