# frozen_string_literal: true

# a class that holds the information needed to play a game of Connect Four
class Game
  include Symbols
  attr_accessor :board, :round, :player1, :player2

  def initialize
    @board = nil
    @player1 = nil
    @player2 = nil
  end

  def play_game
    answer = player_answer

    if answer.match?(/y/i)
      create_players
      @board = Board.new(@player1, @player2)
      @round = 1
      play_round
    else
      puts 'Thank you for checking out the game :)'
    end
  end

  def create_players
    color = player_color
    @player1 = color.match?(/r/i) ? Player.new(red_circle) : Player.new(blue_circle)
    @player2 = color.match?(/r/i) ? Player.new(blue_circle) : Player.new(red_circle)

    puts "Player1: #{player1}\nPlayer2: #{player2}"
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

  def play_round
    if round < 7
      place_symbol
    elsif round < 42
      puts 'is there a winner?'
    else
      puts 'There was a tie!'
      play_game
    end
  end

  def place_symbol
    column = place_column_number

    board.place(column)
    play_round
  end

  def place_column_number
    loop do
      answer = verify_player_number(player_number_input)
      return answer if answer

      # need to add one more level of verification: verify that the same column number is chosen max 6 times

      puts 'Invalid input'
    end
  end

  def verify_player_number(num)
    num.to_i if num.match(/^[1-7]$/)
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

  def player_number_input
    puts 'Please choose a column number from 1 to 7'
    gets.chomp
  end
end
