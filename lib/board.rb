# frozen_string_literal: true

#  a class that handles the methods needed for the board for Connect Four
class Board
  include Symbols

  def initialize
    @board = Array.new(6) { Array.new(7) { empty_circle } }
    print_board
  end

  def print_board
    @board.each { |row| puts row.join(' ') }
    puts [*1..7].join(' ')
  end
end
