class AddUserToMiterFrames < ActiveRecord::Migration[8.0]
  def change
    add_reference :miter_frames, :user, null: false, foreign_key: true
  end
end
