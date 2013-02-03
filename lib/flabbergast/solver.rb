require 'set'

module Flabbergast
  class Solver
    def initialize(dictionary, grid)
      @dictionary = dictionary
      @grid       = grid
    end

    def solve!
      words = Set.new
      words += solve_rows
      words += solve_columns
      words += solve_diagonals
      words.sort
    end

    private

    def solve_rows
      # search each row and its substrings forward and back
      @grid.reduce([]) do |words, row|
        words += search_string_for_words(row.join)
        words += search_string_for_words(row.join.reverse)
        words
      end
    end

    def solve_columns
      # search each column and its substrings forward and back
      (0..@grid.size-1).to_a.reduce([]) do |words, n|
        row_string = @grid.map{|row| row[n]}
        words += search_string_for_words(row_string)
        words += search_string_for_words(row_string.reverse)
        words
      end
    end

    def solve_diagonals
      # search each diagonal and its substrings forward and back
      # only works corner to corner at the moment, needs quite a bit
      # more work to be useful and to search outside corners
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
      words += search_string_for_words(diag1.join)
      words += search_string_for_words(diag1.join.reverse)
      words += search_string_for_words(diag2.join)
      words += search_string_for_words(diag2.join.reverse)
      words
    end

    # recursion through a string and its subs to 2 chars
    def search_string_for_words(string)
      (0..(string.size-1)).to_a.reduce([]) do |words, position|
        current_string = string[position..-1]
        if current_string.size >= 2
          words << current_string if @dictionary.words.has_key?(string)
          words += search_string_for_words(current_string[0..-2])
        end
        words
      end
    end
  end
end
