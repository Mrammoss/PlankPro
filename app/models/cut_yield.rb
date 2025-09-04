# == Schema Information
#
# Table name: cut_yields
#
#  id                :bigint           not null, primary key
#  board_length      :decimal(7, 4)
#  board_length_unit :string
#  piece_length      :decimal(7, 4)
#  piece_length_unit :string
#  pieces_count      :integer
#  waste_length      :decimal(7, 4)
#  waste_length_unit :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  project_id        :bigint           not null
#
# Indexes
#
#  index_cut_yields_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class CutYield < ApplicationRecord
  belongs_to :project
end
