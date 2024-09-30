# frozen_string_literal: true

# a class that holds player information
class Player
  attr_accessor :symbol, :positions

  def initialize(symbol)
    @symbol = symbol
    @positions = []
  end

  def to_s
    @symbol
  end
end
