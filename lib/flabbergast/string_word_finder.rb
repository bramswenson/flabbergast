require 'celluloid'

module Flabbergast
  # Used to find words in a string of letters
  class StringWordFinder

    # @param [String] string a string of letters to be searched
    # @param [Flabbergast::Dictionary] dictionary a dictionary of valid words
    def initialize(string, dictionary)
      @string     = string.respond_to?(:join) ? string.join : string
      @dictionary = dictionary
    end

    # Recursively search the string for words from the dictionary
    # @return [Celluloid::Future] a future that finds words in the string
    def find_words!
      Celluloid::Future.new do
        (0..(@string.size-1)).to_a.reduce([]) do |words, position|
          current_string = @string[position..-1]
          words += recursive_find_words_in_string(current_string)
          words
        end
      end
    end

    private

    def recursive_find_words_in_string(string)
      words = []
      if word = @dictionary.find_entry!(string)
        words << word
      end
      words += recursive_find_words_in_string(string[0..-2]) if string.size >= 2
      words
    end

  end
end
