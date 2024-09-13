# frozen_string_literal: true

# a class that handles the methods needed for the board for Connect Four
class Board
  def initialize
    @board = [*0..41]
    @board.each { |i| @board[i] = '◯' }
    puts @board.length
  end
end
