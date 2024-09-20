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
    # let(:player1_round) { instance_double(Player, red_circle) }
    # let(:player2_round) { instance_double(Player, blue_circle) }
    # let(:board_round) { instance_double(Board, player1_round, player2_round) }
    # before do
    #   game_round.instance_variable_set(:@board, board_round)
    #   game_round.instance_variable_set(:@player1, player1_round)
    #   game_round.instance_variable_set(:@player2, player2_round)
    # end

    context 'when round < 7' do
      before do
        game_round.instance_variable_set(:@round, 5)
      end

      it 'places the appropriate symbol in the indicated column' do
        expect(game_round).to receive(:place_symbol)
        game_round.play_round
      end
    end

    context 'when round is between 7 and 42' do
      before do
        game_round.instance_variable_set(:@round, 9)
      end

      xit 'checks for a winner' do
        expect(game_round).to receive(:puts).with('is there a winner?')
        game_round.play_round
      end
    end

    context 'when round == 42' do
      before do
        game_round.instance_variable_set(:@round, 42)
        allow(game_round).to receive(:player_answer).and_return('n')
      end

      xit 'calls #play_game to start a new Connect Four game' do
        expect(game_round).to receive(:play_game)
        game_round.play_round
      end
    end
  end

  describe '#place_symbol' do
    subject(:game_place_symbol) { described_class.new }
    # let(:player1_place_symbol) { instance_double(Player, game_place_symbol.red_circle) }
    # let(:player2_place_symbol) { instance_double(Player, game_place_symbol.blue_circle) }
    let(:board_place_symbol) { instance_double(Board) }

    before do
      game_place_symbol.instance_variable_set(:@board, board_place_symbol)
      allow(game_place_symbol).to receive(:player_number_input).and_return('7')
      allow(game_place_symbol).to receive(:play_round)
      allow(board_place_symbol).to receive(:place)
    end

    context 'places the appropriate symbol in the appropriate location' do
      it 'calls the board object\'s place method once' do
        expect(board_place_symbol).to receive(:place).with(7)
        game_place_symbol.place_symbol
      end

      it 'calls #play_round' do
        expect(game_place_symbol).to receive(:play_round).once
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

    context 'when user input is valid' do
      before do
        valid_input = '7'
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

    context 'when user inputs an invalid and valid input' do
      before do
        invalid_input = '^^'
        valid_input = '5'
        allow(game_place_column_number).to receive(:player_number_input).and_return(invalid_input, valid_input)
      end

      it 'completes the loop and displays the error message' do
        error_message = 'Invalid input'
        expect(game_place_column_number).to receive(:puts).with(error_message).once
        game_place_column_number.place_column_number
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
