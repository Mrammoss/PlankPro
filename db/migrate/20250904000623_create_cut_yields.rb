class CreateCutYields < ActiveRecord::Migration[8.0]
  def change
    create_table :cut_yields do |t|
      t.decimal :board_length, precision: 7, scale: 4
      t.string  :board_length_unit

      t.decimal :piece_length, precision: 7, scale: 4
      t.string  :piece_length_unit

      t.integer :pieces_count

      t.decimal :waste_length, precision: 7, scale: 4
      t.string  :waste_length_unit

      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
