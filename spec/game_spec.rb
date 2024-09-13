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

      it 'starts a game of connect four' do
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

      it 'puts a meesage to the console and exits' do
        no_message = ':)'
        expect(game_play_game).to receive(:puts).with(no_message)
        game_play_game.play_game
      end
    end

    context 'when a user inputs an invalid input' do
      before do
        invalid_input = 'x'
        allow(game_play_game).to receive(:player_answer).and_return(invalid_input)
      end

      it 'an error message is shown' do
        invalid_message = 'Invalid input. Please enter (Y/N) only.'
        expect(game_play_game).to receive(:puts).with(invalid_message)
        game_play_game.play_game
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
