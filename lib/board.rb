# frozen_string_literal: true

#  a class that handles the methods needed for the board for Connect Four
class Board
  include Symbols

  attr_reader :board

  HORIZONTAL = [[0, -1], [0, 1]].freeze
  VERTICAL = [[-1, 0], [1, 0]].freeze
  DIAGONAL_DOWN = [[-1, -1], [1, 1]].freeze
  DIAGONAL_UP = [[1, -1], [-1, 1]].freeze
  TRANSFORMATIONS = [HORIZONTAL, VERTICAL, DIAGONAL_DOWN, DIAGONAL_UP].freeze

  def initialize
    @board = Array.new(6) { Array.new(7) { empty_circle } }
    print_board
  end

  def update_board(row, column, symbol)
    @board[row][column - 1] = symbol
    print_board
  end

  def check_rows(row, column, symbol)
    matches = []
    TRANSFORMATIONS.each do |transform_item|
      total = 1
      transform_item.each do |transformation|
        total += check_transformation([row, column - 1], transformation, symbol)
      end
      matches << total
    end
    matches.max
  end

  def check_transformation(coord, transformation, symbol, matching = 0)
    new_row = coord[0] + transformation[0]
    new_column = coord[1] + transformation[1]
    return matching unless new_row.between?(0, 5) && new_column.between?(0, 6)
    return matching unless board[new_row][new_column] == symbol

    matching += 1 if board[new_row][new_column] == symbol

    check_transformation([new_row, new_column], transformation, symbol, matching)
  end

  private

  def print_board
    @board.each { |row| puts row.join(' ') }
    puts [*1..7].join(' ')
  end
end
