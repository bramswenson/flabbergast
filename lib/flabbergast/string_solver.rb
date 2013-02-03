require 'celluloid'

module Flabbergast
  class StringSolver

    def initialize(string, dictionary)
      @string     = string
      @dictionary = dictionary
      @size       = string.size
    end

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
