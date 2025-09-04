class CreateMiterFrames < ActiveRecord::Migration[8.0]
  def change
    create_table :miter_frames do |t|
      t.decimal :inside_width, precision: 7, scale: 4
      t.string  :inside_width_unit

      t.decimal :inside_height, precision: 7, scale: 4
      t.string  :inside_height_unit

      t.decimal :board_width, precision: 6, scale: 4
      t.string  :board_width_unit

      t.decimal :joint_angle, precision: 5, scale: 3
      t.decimal :miter_angle_one, precision: 5, scale: 3
      t.decimal :miter_angle_two, precision: 5, scale: 3

      t.decimal :piece_length, precision: 7, scale: 4
      t.string  :piece_length_unit

      t.decimal :total_material, precision: 8, scale: 4
      t.string  :total_material_unit

      t.decimal :waste_length, precision: 7, scale: 4
      t.string  :waste_length_unit

      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
