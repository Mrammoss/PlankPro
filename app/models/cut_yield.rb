# == Schema Information
#
# Table name: cut_yields
#
#  id                :bigint           not null, primary key
#  board_length      :decimal(7, 4)
#  board_length_unit :string
#  name              :string
#  piece_length      :decimal(7, 4)
#  piece_length_unit :string
#  pieces_count      :integer
#  waste_length      :decimal(7, 4)
#  waste_length_unit :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_cut_yields_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class CutYield < ApplicationRecord
  belongs_to :user
  before_save :calculate_waste_length_decimal, :calculate_pieces_count

  SAW_THICKNESS = Rational(1, 8)

  attr_accessor :board_length_whole, :board_length_numerator, :board_length_denominator
  attr_accessor :piece_length_whole, :piece_length_numerator, :piece_length_denominator

  before_validation :combine_board_length, :combine_piece_length

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

  def board_length_display
    format_fraction(board_length&.to_r)
  end

  def piece_length_display
    format_fraction(piece_length&.to_r)
  end

  def waste_length_display
    format_fraction(calculated_waste_length&.to_r)
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

  def calculated_waste_length
    pieces = calculated_pieces_count
    total_cuts = pieces
    board_length - (pieces * piece_length + total_cuts * SAW_THICKNESS )
  end

  def calculated_pieces_count
    return 0 if piece_length.to_f.zero?
    ((board_length + SAW_THICKNESS) / (piece_length + SAW_THICKNESS)).floor
  end

  def calculate_waste_length_decimal
    self.waste_length = calculated_waste_length.to_f
  end

  def calculate_pieces_count
    self.pieces_count = calculated_pieces_count
  end
end
