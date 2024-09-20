# frozen_string_literal: true

require_relative '../lib/symbols'
require_relative '../lib/board'

describe Board do
  describe '#place' do
    subject(:board_update_board) { described_class.new }
    it 'updates the board with the correct symbol in the correct place' do
      row = 5
      column = 2
      symbol = board_update_board.red_circle
      board_update_board.update_board(column, row, symbol)
      updated_board = board_update_board.instance_variable_get(:@board)
      expect(updated_board[row][column - 1]).to eql(symbol)
    end
  end
end
