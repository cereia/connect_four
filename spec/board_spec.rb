# frozen_string_literal: true

require_relative '../lib/symbols'
require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

describe Board do
  describe '#update_board' do
    subject(:board_update_board) { described_class.new }
    it 'updates the board with the correct symbol in the correct place' do
      row = 5
      column = 2
      symbol = board_update_board.red_circle
      board_update_board.update_board(row, column, symbol)
      updated_board = board_update_board.instance_variable_get(:@board)
      expect(updated_board[row][column - 1]).to eql(symbol)
    end
  end

  describe '#check_rows' do
    subject(:board_check_rows) { described_class.new }

    context 'when there is only 1 line of the same, adjacent symbol' do
      before do
        board_check_rows.update_board(5, 2, board_check_rows.red_circle)
        board_check_rows.update_board(5, 3, board_check_rows.blue_circle)
        board_check_rows.update_board(4, 2, board_check_rows.red_circle)
        board_check_rows.update_board(5, 4, board_check_rows.blue_circle)
        board_check_rows.update_board(3, 2, board_check_rows.red_circle)
      end

      it 'returns the number of matching symbols given a position on the board' do
        row = 5
        column = 2
        symbol = board_check_rows.red_circle
        matches = board_check_rows.check_rows(row, column, symbol)
        expect(matches).to eql(3)
      end
    end

    context 'when there are 2 or more lines of the same, adjacent symbol' do
      before do
        board_check_rows.update_board(5, 4, board_check_rows.red_circle)
        board_check_rows.update_board(5, 2, board_check_rows.blue_circle)
        board_check_rows.update_board(5, 5, board_check_rows.red_circle)
        board_check_rows.update_board(5, 3, board_check_rows.blue_circle)
        board_check_rows.update_board(5, 6, board_check_rows.red_circle)
        board_check_rows.update_board(5, 7, board_check_rows.blue_circle)
        board_check_rows.update_board(4, 4, board_check_rows.red_circle)
        board_check_rows.update_board(5, 1, board_check_rows.blue_circle)
      end

      it 'returns only the highest number of matching symbols given a position on the board' do
        row = 5
        column = 4
        symbol = board_check_rows.red_circle
        matches = board_check_rows.check_rows(row, column, symbol)
        expect(matches).to eql(3)
      end
    end
  end

  describe '#check_transformation' do
    subject(:board_check_transformation) { described_class.new }

    before do
      board_check_transformation.update_board(5, 4, board_check_transformation.red_circle)
      board_check_transformation.update_board(5, 2, board_check_transformation.blue_circle)
      board_check_transformation.update_board(5, 5, board_check_transformation.red_circle)
      board_check_transformation.update_board(5, 3, board_check_transformation.blue_circle)
      board_check_transformation.update_board(5, 6, board_check_transformation.red_circle)
      board_check_transformation.update_board(4, 2, board_check_transformation.blue_circle)
      board_check_transformation.update_board(4, 4, board_check_transformation.red_circle)
      board_check_transformation.update_board(3, 2, board_check_transformation.blue_circle)
    end

    it 'returns the number of matching symbols in a particular, vertical, line excluding starting point' do
      vertical = Board::VERTICAL[0]
      coord = [5, 1]
      symbol = board_check_transformation.blue_circle
      matching = board_check_transformation.check_transformation(coord, vertical, symbol)
      expect(matching).to eql(2)
    end

    it 'returns the number of matching symbols in a particular, horizontal, line excluding starting point' do
      horizontal = Board::HORIZONTAL[0]
      coord = [5, 5]
      symbol = board_check_transformation.red_circle
      matching = board_check_transformation.check_transformation(coord, horizontal, symbol)
      expect(matching).to eql(2)
    end
  end
end

# rubocop:enable Metrics/BlockLength
