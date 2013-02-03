require 'set'
require 'celluloid'
require 'flabbergast/string_word_finder'

module Flabbergast
  # Used to find all the words in a word grid puzzle
  class GridWordFinder

    # @param [Flabbergast::Dictionary] dictionary a dictionary of valid words
    # @param [Array[Array]] grid an array of arrays of letters
    def initialize(dictionary, grid)
      @dictionary = dictionary
      @grid       = grid
    end

    # Search the grid for words from the dictionary
    # @return [Set] a set of words found on the grid
    def find_words!
      words = Set.new
      futures = %w( rows columns diagonals ).map do |direction|
        send "find_#{direction}"
      end
      words += words_from_futures(futures)
      words.sort
    end

    private

    def words_from_futures(futures)
      futures.reduce([]) do |words, future|
        words += future.value
        words
      end
    end

    def find_and_collect_words(string)
      futures = [ string, string.reverse ].map do |string|
        Flabbergast::StringWordFinder.new(string, @dictionary).find_words!
      end
      words_from_futures(futures)
    end

    # NOTE: long term these find_ methods might be better as classes
    def find_rows
      Celluloid::Future.new do
        # search each row and its substrings forward and back
        @grid.reduce([]) do |words, row|
          words += find_and_collect_words(row.join)
          words
        end
      end
    end

    def find_columns
      Celluloid::Future.new do
        # search each column and its substrings forward and back
        (0..@grid.size-1).to_a.reduce([]) do |words, n|
          row_string = @grid.map{|row| row[n]}
          words += find_and_collect_words(row_string)
          words
        end
      end
    end

    def find_diagonals
      Celluloid::Future.new do
        # search each diagonal and its substrings forward and back
        # only works corner to corner at the moment, needs quite a bit
        # more work to be useful and to search outside corners
        # omega mess though, so i'm ok with it
        grid_range = (0..@grid.size-1).to_a
        words = []
        diag1 = grid_range.reduce([]) do |word, x|
          word << @grid[x][x]
          word
        end
        diag2 = grid_range.reverse.reduce([]) do |word, x|
          word << @grid[x][@grid.size-x]
          word
        end
        words += find_and_collect_words(diag1.join)
        words += find_and_collect_words(diag2.join)
        words
      end
    end
  end
end
