# frozen_string_literal: true

# a module that holds the symbols necessary for a game of Connect Four
module Symbols
  def red_circle
    "\e[31m\u2B24\e[0m"
  end

  def blue_circle
    "\e[34m\u2B24\e[0m"
  end

  def empty_circle
    "\u2B24"
  end
end
