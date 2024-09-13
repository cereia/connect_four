# frozen_string_literal: true

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
      end

      it 'creates a new Board object' do
        expect(Board).to receive(:new)
        game_play_game.play_game
      end

      it 'asks for a color' do
        yes_message = 'Would you like to be red or blue? (R/B)'
        expect(game_play_game).to receive(:puts).with(yes_message)
        game_play_game.play_game
      end
    end

    context 'when a user inputs a valid no input' do
      before do
        no_input = 'n'
        allow(game_play_game).to receive(:player_answer).and_return(no_input)
      end

      it 'puts a message to the console and exits' do
        no_message = ':)'
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
end

# rubocop:enable Metrics/BlockLength
