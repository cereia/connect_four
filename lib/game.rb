# frozen_string_literal: true

# a class that holds the information needed to play a game of Connect Four
class Game
  def initialize
    @board = nil
  end

  def play_game
    answer = player_answer

    if answer.match?(/y/i)
      @board = Board.new
      puts 'Would you like to be red or blue? (R/B)'
    else
      puts ':)'
    end
  end

  def player_answer
    loop do
      answer = verify_player_answer(player_answer_input)
      return answer if answer

      puts 'Invalid input. Please enter (Y/N).'
    end
  end

  def verify_player_answer(answer)
    answer if answer.match?(/^[y|n]$/i)
  end

  private

  def player_answer_input
    puts 'Would you like to play Connect Four? (Y/N)'
    gets.chomp
  end
end
