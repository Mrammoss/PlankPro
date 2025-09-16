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
#  miter_angle         :float
#  miter_angle_one     :decimal(5, 3)
#  miter_angle_two     :decimal(5, 3)
#  piece_length        :decimal(7, 4)
#  piece_length_unit   :string
#  shape_type          :string
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
  belongs_to :user

  SAW_THICKNESS = Rational(1, 8)

  attr_accessor :inside_length_whole, :inside_length_numerator, :inside_length_denominator
  attr_accessor :outside_length_whole, :outside_length_numerator, :outside_length_denominator
  attr_accessor :board_width_whole, :board_width_numerator, :board_width_denominator

  attr_accessor :outside_length_input

  # No more square sides
  before_validation :combine_fractions, :calculate_lengths

  def combine_fractions
    self.inside_length = combine_fraction(inside_length_whole, inside_length_numerator, inside_length_denominator)
    self.outside_length_input = combine_fraction(outside_length_whole, outside_length_numerator, outside_length_denominator)
    self.board_width = combine_fraction(board_width_whole, board_width_numerator, board_width_denominator)
  end

  def combine_fraction(whole, numerator, denominator)
    whole = whole.to_i
    numerator = numerator.to_i
    denominator = denominator.to_i
    denominator = 1 if denominator.zero?
    Rational(whole) + Rational(numerator, denominator)
  end

  def number_of_sides
    case shape_type
    when "triangle" then 3
    when "rectangle" then 4
    when "pentagon" then 5
    when "hexagon" then 6
    else 4
    end
  end

  def calculate_lengths
    return if board_width.blank? || number_of_sides.blank?

    n = number_of_sides
    self.miter_angle = 180.0 / n

    offset = 2 * board_width * Math.tan(Math::PI / n)

    if inside_length.present? && outside_length_input.blank?
      self.outside_length_input = inside_length + offset
    elsif outside_length_input.present? && inside_length.blank?
      # inside length from outside length
      self.inside_length = outside_length_input - offset
    end
  end

  def format_fraction(rational)
    return "" if rational.nil?
    whole = rational.to_i
    remainder = rational - whole
    if remainder.zero?
      whole.to_s
    elsif whole.zero?
      "#{remainder.numerator}/#{remainder.denominator}"
    else
      "#{whole} #{remainder.numerator}/#{remainder.denominator}"
    end
  end

  def inside_length_display
    format_fraction(inside_length)
  end

  def outside_length_display
    format_fraction(outside_length_input.to_r)
  end

  def board_width_display
    format_fraction(board_width)
  end
end
