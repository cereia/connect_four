# frozen_string_literal: true

# a class that holds the information needed to play a game of Connect Four
class Game
  include Symbols
  attr_accessor :board, :round, :player1, :player2

  def initialize
    @board = nil
    @player1 = nil
    @player2 = nil
    @column_history = []
  end

  def play_game
    answer = player_answer

    if answer.match?(/y/i)
      create_players
      @board = Board.new
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
    if round < 43
      place_symbol
    else
      puts 'There was a tie!'
      restart
    end
  end

  def place_symbol
    puts "It is #{player_symbol}'s turn."
    column = place_column_number
    row = 5 - times_a_column_was_picked(column)
    player = player_symbol

    board.update_board(row, column, player)
    check_for_game_over(row, column, player)
  end

  def check_for_game_over(row, column, symbol)
    if @board.check_rows(row, column, symbol) > 3
      puts "The winner is #{symbol == player1.symbol ? 'Player1' : 'Player2'}!"
      restart
    else
      @column_history << column
      @round += 1
      play_round
    end
  end

  def player_symbol
    round.odd? ? player1.symbol : player2.symbol
  end

  def place_column_number
    loop do
      number = verify_player_number(player_number_input)
      return number if number && times_a_column_was_picked(number) < 6

      puts 'Invalid input'
    end
  end

  def verify_player_number(num)
    num.to_i if num.match(/^[1-7]$/)
  end

  def times_a_column_was_picked(column)
    @column_history.count(column)
  end

  def restart
    new_game = Game.new
    new_game.play_game
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
