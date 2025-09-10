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

  SAW_THICKNESS = Rational(1,8)


  attr_accessor :inside_length_whole, :inside_length_numerator, :inside_length_denominator
  attr_accessor :outside_length_whole, :outside_length_numerator, :outside_length_denominator
  attr_accessor :board_width_whole, :board_width_numerator, :board_width_denominator

  # No more square sides
  before_validation :combine_fractions, :calculate_lengths


  def combine_fractions
    self.inside_length = 
    self.outside_length =
    self.board_width = 
  end

  def combine_fraction(whole, numerator, denominator)
    whole = whole.to_i
    numerator = numerator.to_i
    denominator = denominator.to_i
    denominator = 1 if denominator.zero?
  end

  def calculate_lengths

    return if board_width.blank? || number_of_sides.blank?

    n = number_of_sides
    interior_angle = (n - 2) * 180.0 / n
    
  end

  def calculate_piece_length

  end

end
