# == Schema Information
#
# Table name: miter_frames
#
#  id                  :bigint           not null, primary key
#  board_width         :decimal(6, 4)
#  board_width_unit    :string
#  inside_height       :decimal(7, 4)
#  inside_height_unit  :string
#  inside_width        :decimal(7, 4)
#  inside_width_unit   :string
#  joint_angle         :decimal(5, 3)
#  miter_angle_one     :decimal(5, 3)
#  miter_angle_two     :decimal(5, 3)
#  piece_length        :decimal(7, 4)
#  piece_length_unit   :string
#  total_material      :decimal(8, 4)
#  total_material_unit :string
#  waste_length        :decimal(7, 4)
#  waste_length_unit   :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  project_id          :bigint           not null
#
# Indexes
#
#  index_miter_frames_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class MiterFrame < ApplicationRecord
  belongs_to :project
end
