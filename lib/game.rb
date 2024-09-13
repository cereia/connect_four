# frozen_string_literal: true

# a class that holds the information needed to play a game of Connect Four
class Game
  attr_accessor :board

  def initialize
    @board = nil
    @player1 = nil
    @player2 = nil
  end

  def play_game
    answer = player_answer

    if answer.match?(/y/i)
      @board = Board.new
      create_players
    else
      puts 'Thank you for checking out the game :)'
    end
  end

  def create_players
    color = player_color
    @player1 = color.match?(/r/i) ? Player.new('🔴') : Player.new('🔵')
    @player2 = color.match?(/r/i) ? Player.new('🔵') : Player.new('🔴')

    puts "Player1: #{@player1}\nPlayer2: #{@player2}"
  end

  def player_color
    loop do
      color = verify_player_color(player_color_input)
      return color if color

      puts 'Invalid input. Please enter (R/B).'
    end
  end

  def verify_player_color(color)
    color[0] if color.match?(/^b[lue]*|^r[ed]*/i)
  end

  def player_answer
    loop do
      answer = verify_player_answer(player_answer_input)
      return answer if answer

      puts 'Invalid input. Please enter (Y/N).'
    end
  end

  def verify_player_answer(answer)
    answer if answer.match?(/^y[es]*|^no*/i)
  end

  private

  def player_answer_input
    puts 'Would you like to play Connect Four? (Y/N)'
    gets.chomp
  end

  def player_color_input
    puts 'Would you like to be red or blue? (R/B)'
    gets.chomp
  end
end
