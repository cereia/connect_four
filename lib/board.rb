# frozen_string_literal: true

#  a class that handles the methods needed for the board for Connect Four
class Board
  include Symbols

  def initialize
    @board = Array.new(6) { Array.new(7) { empty_circle } }
    print_board
    # @player1 = player1
    # @player2 = player2
  end

  def update_board(column, row, player_symbol)
    @board[row][column - 1] = player_symbol
    print_board
  end

  private

  def print_board
    @board.each { |row| puts row.join(' ') }
    puts [*1..7].join(' ')
  end
end
