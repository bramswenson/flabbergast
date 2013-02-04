require 'set'
require 'celluloid'
require 'flabbergast/string_word_finder'

module Flabbergast

  # Base class for all finders wrapping futures helpers and initalization
  class BaseGridWordFinder
    # @param [Flabbergast::Dictionary] dictionary a dictionary of valid words
    # @param [Array[Array]] grid an array of arrays of letters
    def initialize(dictionary, grid)
      @dictionary = dictionary
      @grid       = grid
    end

    protected

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
  end

  # Used to find all the words in a word grid puzzle
  class GridWordFinder < BaseGridWordFinder

    # Search the grid for words from the dictionary
    # @return [Set] a set of words found on the grid
    def find_words!
      words = Set.new
      #futures = %w( rows columns diagonals ).map do |direction|
      futures = [
        Flabbergast::GridRowWordFinder,
        Flabbergast::GridColumnWordFinder,
        Flabbergast::GridDiagonalWordFinder,
      ].map do |finder|
        finder.new(@dictionary, @grid).find_words!
      end
      words += words_from_futures(futures)
      words.sort
    end
  end

  # Used to find all the words in a word grids rows
  class GridRowWordFinder < BaseGridWordFinder
    def find_words!
      Celluloid::Future.new do
        @grid.reduce([]) do |words, row|
          words += find_and_collect_words(row.join)
          words
        end
      end
    end
  end

  # Used to find all the words in a word grids columns
  class GridColumnWordFinder < BaseGridWordFinder
    def find_words!
      Celluloid::Future.new do
        (0..@grid.size-1).to_a.reduce([]) do |words, n|
          row_string = @grid.map{|row| row[n]}
          words += find_and_collect_words(row_string)
          words
        end
      end
    end
  end

  # Used to find all the words in a word grids diagonals
  class GridDiagonalWordFinder < BaseGridWordFinder
    def find_words!
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
          word << @grid[x][(@grid.size-1)-x]
          word
        end
        words += find_and_collect_words(diag1.join)
        words += find_and_collect_words(diag2.join)
        words
      end
    end
  end
end
