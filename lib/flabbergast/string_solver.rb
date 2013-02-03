require 'celluloid'

module Flabbergast
  # Used to find words in a string of letters
  class StringSolver

    # @param [String] string a string of letters to be searched
    # @param [Flabbergast::Dictionary] dictionary a dictionary of valid words
    def initialize(string, dictionary)
      @string     = string
      @dictionary = dictionary
      @size       = string.size
    end

    # Recursively search the string for words from the dictionary
    # @return [Celluloid::Future] a future that finds words in the string
    def solve
      Celluloid::Future.new do
        (0..(@size-1)).to_a.reduce([]) do |words, position|
          current_string = @string[position..-1]
          if current_string.size >= 2
            words << current_string if @dictionary.words.has_key?(current_string)
            words += self.class.new(current_string[0..-2], @dictionary).solve.value
          end
          words
        end
      end
    end
  end
end
