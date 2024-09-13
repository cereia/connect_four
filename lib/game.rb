# frozen_string_literal: true

# a class that holds the information needed to play a game of Connect Four
class Game
  def initialize
    @board = nil
  end

  def play_game
    answer = player_answer

    if answer.match?(/y/i)
      puts 'Would you like to be red or blue? (R/B)'
    elsif answer.match?(/n/i)
      puts ':)'
    else
      puts 'Invalid input. Please enter (Y/N) only.'
    end
  end

  private

  def player_answer
    puts 'Would you like to play Connect Four? (Y/N)'
    gets.chomp
  end
end
