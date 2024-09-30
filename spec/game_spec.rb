# frozen_string_literal: true

require_relative '../lib/symbols'
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/game'

# rubocop:disable Metrics/BlockLength

describe Game do
  describe '#play_game' do
    subject(:game_play_game) { described_class.new }

    context 'when a user inputs a valid yes input' do
      before do
        yes_input = 'y'
        allow(game_play_game).to receive(:player_answer).and_return(yes_input)
        allow(game_play_game).to receive(:play_round)
      end

      it 'creates a new Board object' do
        expect(Board).to receive(:new)
        game_play_game.play_game
      end

      it 'calls #create_players once' do
        expect(game_play_game).to receive(:create_players).once
        game_play_game.play_game
      end
    end

    context 'when a user inputs a valid no input' do
      before do
        no_input = 'n'
        allow(game_play_game).to receive(:player_answer).and_return(no_input)
      end

      it 'puts a message to the console and exits' do
        no_message = 'Thank you for checking out the game :)'
        expect(game_play_game).to receive(:puts).with(no_message)
        game_play_game.play_game
      end
    end
  end

  describe '#player_answer' do
    subject(:game_player_answer) { described_class.new }

    context 'when a user inputs a valid input' do
      before do
        valid_input = 'N'
        allow(game_player_answer).to receive(:player_answer_input).and_return(valid_input)
      end

      it 'returns valid input' do
        answer = game_player_answer.player_answer
        expect(answer).to eq('N')
      end

      it 'stops the loop and does not display an error message' do
        invalid_message = 'Invalid input. Please enter (Y/N).'
        expect(game_player_answer).not_to receive(:puts).with(invalid_message)
        game_player_answer.player_answer
      end
    end

    context 'when a user inputs an invalid answer and a valid one' do
      before do
        invalid_input = 'x'
        valid_input = 'n'
        allow(game_player_answer).to receive(:player_answer_input).and_return(invalid_input, valid_input)
      end

      it 'completes one loop and an error message is shown' do
        invalid_message = 'Invalid input. Please enter (Y/N).'
        expect(game_player_answer).to receive(:puts).with(invalid_message).once
        game_player_answer.player_answer
      end
    end

    context 'when a user inputs 2 invalid inputs and a valid one' do
      before do
        invalid1 = '@'
        invalid2 = '234'
        valid_input = 'n'
        allow(game_player_answer).to receive(:player_answer_input).and_return(invalid1, invalid2, valid_input)
      end

      it 'completes two loops and displays an error message twice' do
        invalid_message = 'Invalid input. Please enter (Y/N).'
        expect(game_player_answer).to receive(:puts).with(invalid_message).twice
        game_player_answer.player_answer
      end
    end
  end

  describe '#verify_player_answer' do
    subject(:game_verify_answer) { described_class.new }

    context 'when user input is valid' do
      it 'returns a valid input' do
        user_input = 'n'
        verified_input = game_verify_answer.verify_player_answer(user_input)
        expect(verified_input).to eq('n')
      end
    end

    context 'when user input is invalid' do
      it 'returns nil' do
        user_input = '3'
        verified_input = game_verify_answer.verify_player_answer(user_input)
        expect(verified_input).to be_nil
      end
    end
  end

  describe '#create_players' do
    subject(:game_create_players) { described_class.new }

    before do
      red_input = 'r'
      allow(game_create_players).to receive(:player_color).and_return(red_input)
    end

    it 'creates two new Player instances' do
      expect(Player).to receive(:new).twice
      game_create_players.create_players
    end
  end

  describe '#player_color' do
    subject(:game_player_color) { described_class.new }

    context 'when a user input is valid' do
      before do
        valid_input = 'red'
        allow(game_player_color).to receive(:player_color_input).and_return(valid_input)
      end

      it 'returns valid input' do
        color = game_player_color.player_color
        expect(color).to eq('r')
      end

      it 'stops the loop and does not display an error message' do
        invalid_message = 'Invalid input. Please enter (R/B).'
        expect(game_player_color).not_to receive(:puts).with(invalid_message)
        game_player_color.player_color
      end
    end

    context 'when a user inputs an invalid and a valid input' do
      before do
        invalid_input = ')'
        valid_input = 'b'
        allow(game_player_color).to receive(:player_color_input).and_return(invalid_input, valid_input)
      end

      it 'completes a loop and displays an error message' do
        invalid_message = 'Invalid input. Please enter (R/B).'
        expect(game_player_color).to receive(:puts).with(invalid_message).once
        game_player_color.player_color
      end
    end

    context 'when a user inputs 3 invalid and one valid input' do
      before do
        invalid1 = '<'
        invalid2 = '34'
        invalid3 = 'we'
        valid = 'R'
        allow(game_player_color).to receive(:player_color_input).and_return(invalid1, invalid2, invalid3, valid)
      end

      it 'completes 3 loops and displays error message 3 times' do
        invalid_message = 'Invalid input. Please enter (R/B).'
        expect(game_player_color).to receive(:puts).with(invalid_message).exactly(3).times
        game_player_color.player_color
      end
    end
  end

  describe '#verify_player_color' do
    subject(:game_verify_color) { described_class.new }

    context 'when user input is valid' do
      it 'returns valid input' do
        valid_color = 'RE'
        verified_color = game_verify_color.verify_player_color(valid_color)
        expect(verified_color).to eq('R')
      end

      it 'returns valid input' do
        valid_color = 'blu'
        verified_color = game_verify_color.verify_player_color(valid_color)
        expect(verified_color).to eq('b')
      end
    end

    context 'when user input is invalid' do
      it 'returns nil' do
        invalid_input = 'pink'
        verified_color = game_verify_color.verify_player_color(invalid_input)
        expect(verified_color).to be_nil
      end

      it 'returns nil' do
        invalid_input = '&'
        verified_color = game_verify_color.verify_player_color(invalid_input)
        expect(verified_color).to be_nil
      end
    end
  end

  describe '#play_round' do
    subject(:game_round) { described_class.new }

    context 'when round is < 43' do
      before do
        game_round.instance_variable_set(:@round, 9)
        allow(game_round).to receive(:place_symbol)
      end

      it 'calls #place_symbol' do
        expect(game_round).to receive(:place_symbol)
        game_round.play_round
      end
    end

    context 'when round > 42' do
      before do
        game_round.instance_variable_set(:@round, 43)
        allow(game_round).to receive(:player_answer).and_return('n')
      end

      it 'calls #restart to start a new Connect Four game' do
        expect(game_round).to receive(:restart)
        game_round.play_round
      end
    end
  end

  describe '#place_symbol' do
    subject(:game_place_symbol) { described_class.new }
    let(:player1_place_symbol) { instance_double(Player, symbol: game_place_symbol.red_circle, positions: []) }
    let(:player2_place_symbol) { instance_double(Player, symbol: game_place_symbol.blue_circle, positions: []) }
    let(:board_place_symbol) { instance_double(Board) }

    before do
      game_place_symbol.instance_variable_set(:@board, board_place_symbol)
      game_place_symbol.instance_variable_set(:@round, 3)
      game_place_symbol.instance_variable_set(:@player1, player1_place_symbol)
      game_place_symbol.instance_variable_set(:@player2, player2_place_symbol)
      game_place_symbol.instance_variable_set(:@column_history, [1, 4])
      allow(game_place_symbol).to receive(:player_number_input).and_return('7')
      allow(board_place_symbol).to receive(:update_board)
      allow(game_place_symbol).to receive(:check_for_game_over)
    end

    context 'places the appropriate symbol in the appropriate location' do
      it 'calls the board object\'s #update_board method once' do
        symbol = game_place_symbol.red_circle
        expect(board_place_symbol).to receive(:update_board).with(5, 7, symbol).once
        game_place_symbol.place_symbol
      end

      it 'calls #check_for_game_over once' do
        symbol = game_place_symbol.red_circle
        expect(game_place_symbol).to receive(:check_for_game_over).with(5, 7, symbol).once
        game_place_symbol.place_symbol
      end
    end
  end

  describe '#verify_player_number' do
    subject(:game_verify_number) { described_class.new }

    context 'when user input is valid' do
      it 'returns valid input' do
        valid_input = '4'
        allow(game_verify_number).to receive(:player_number_input).and_return(valid_input)
        verified_number = game_verify_number.verify_player_number(valid_input)
        expect(verified_number).to eq(4)
      end
    end

    context 'when user input is invalid' do
      it 'returns nil' do
        invalid_input = '9'
        allow(game_verify_number).to receive(:player_number_input).and_return(invalid_input)
        verified_number = game_verify_number.verify_player_number(invalid_input)
        expect(verified_number).to be_nil
      end
    end
  end

  describe '#place_column_number' do
    subject(:game_place_column_number) { described_class.new }

    context 'when user input is valid and input was chosen less than 6 times' do
      before do
        valid_input = '7'
        game_place_column_number.instance_variable_set(:@column_history, [1, 1, 5, 7])
        allow(game_place_column_number).to receive(:player_number_input).and_return(valid_input)
      end

      it 'stops the loop and does not display the error message' do
        error_message = 'Invalid input'
        expect(game_place_column_number).not_to receive(:puts).with(error_message)
        game_place_column_number.place_column_number
      end

      it 'returns valid input' do
        expect(game_place_column_number.place_column_number).to eq(7)
      end
    end

    context 'when user inputs a valid input that was chosen more than 6 times and another valid input' do
      before do
        invalid_input = '3'
        valid_input = '1'
        game_place_column_number.instance_variable_set(:@column_history, [3, 3, 3, 3, 3, 1, 3])
        allow(game_place_column_number).to receive(:player_number_input).and_return(invalid_input, valid_input)
      end

      it 'completes a loop and displays the error message once' do
        error_message = 'Invalid input'
        expect(game_place_column_number).to receive(:puts).with(error_message).once
        game_place_column_number.place_column_number
      end
    end

    context 'when user inputs an invalid and valid input' do
      before do
        invalid_input = '^^'
        valid_input = '5'
        allow(game_place_column_number).to receive(:player_number_input).and_return(invalid_input, valid_input)
      end

      it 'completes the loop and displays the error message once' do
        error_message = 'Invalid input'
        expect(game_place_column_number).to receive(:puts).with(error_message).once
        game_place_column_number.place_column_number
      end
    end
  end

  describe '#times_a_column_was_picked' do
    subject(:game_times_picked) { described_class.new }

    it 'returns the number of times a column number appears in the @column_history' do
      game_times_picked.instance_variable_set(:@column_history, [1, 4, 1, 2, 4, 6, 7])

      times = game_times_picked.times_a_column_was_picked(1)
      expect(times).to eql(2)
    end
  end

  describe '#check_for_game_over' do
    subject(:game_game_over) { described_class.new }
    let(:board_game_over) { instance_double(Board) }
    let(:player1_game_over) { instance_double(Player, symbol: game_game_over.red_circle) }
    let(:player2_game_over) { instance_double(Player, symbol: game_game_over.blue_circle) }

    before do
      game_game_over.instance_variable_set(:@board, board_game_over)
      game_game_over.instance_variable_set(:@player1, player1_game_over)
      game_game_over.instance_variable_set(:@player2, player2_game_over)
    end

    context 'when there is a winner' do
      before do
        allow(game_game_over).to receive(:restart)
        allow(board_game_over).to receive(:check_rows).and_return(4)
        game_game_over.instance_variable_set(:@round, 7)
      end

      it 'prints a winner message to the console' do
        row = 5
        column = 2
        symbol = game_game_over.red_circle
        win_message = 'The winner is Player1!'
        expect(game_game_over).to receive(:puts).with(win_message)
        game_game_over.check_for_game_over(row, column, symbol)
      end

      it 'calls #restart' do
        row = 5
        column = 2
        symbol = game_game_over.red_circle
        expect(game_game_over).to receive(:restart).once
        game_game_over.check_for_game_over(row, column, symbol)
      end
    end

    context 'when there is no winner' do
      before do
        allow(board_game_over).to receive(:check_rows).and_return(2)
        allow(game_game_over).to receive(:play_round).and_return(1)
        game_game_over.instance_variable_set(:@column_history, [1, 2, 5])
        game_game_over.instance_variable_set(:@round, 4)
      end

      it 'appends the column number to @column history' do
        symbol = game_game_over.blue_circle
        game_game_over.check_for_game_over(5, 5, symbol)
        history = game_game_over.instance_variable_get(:@column_history)
        expect(history).to eql([1, 2, 5, 5])
      end

      it 'increments @round by 1' do
        symbol = game_game_over.blue_circle
        game_game_over.check_for_game_over(5, 5, symbol)
        expect do
          game_game_over.check_for_game_over(5, 5, symbol)
        end.to change(game_game_over, :round).by(1)
      end

      it 'calls #play_round once' do
        expect(game_game_over).to receive(:play_round).once
        symbol = game_game_over.blue_circle
        game_game_over.check_for_game_over(5, 5, symbol)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
