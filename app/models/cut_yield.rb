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

  SAW_THICKNESS = Rational(1, 8)

  before_validation :combine_board_length, combine_piece_length

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

  def board_length_display
    format_fraction(board_length)
  end

  def piece_length_display
    format_fraction(piece_length)
  end 

  def combine_board_length
    return if board_length_whole.blank? && board_length_numerator.blank? && board_length_denominator.blank?

    whole = board_length_whole.to_i
    numerator = board_length_numerator.to_i
    denominator = board_length_denominator.to_i

    denominator = 1 if denominator.zero?
    self.board_length = Rational(whole) + Rational(numerator, denominator)
  end

  def combine_piece_length
    return if piece_length_whole.blank? && piece_length_numerator.blank? && piece_length_denominator.blank?

    whole = piece_length_whole.to_i
    numerator = piece_length_numerator.to_i
    denominator = piece_length_denominator.to_i

    denominator = 1 if denominator.zero?
    self.piece_length = Rational(whole) + Rational(numerator, denominator)
  end

  def pieces_count
    return 0 if piece_length.to_f.zero?
    ((board_length + SAW_THICKNESS) / (piece_length + SAW_THICKNESS)).floor
  end

  def waste_length
    board_length - (pieces_count * piece_length + SAW_THICKNESS * (pieces_count - 1))
  end
end
