# frozen_string_literal: true

# a class that holds player information
class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def to_s
    @symbol
  end
end
