require 'set'
require 'celluloid'
require 'flabbergast/string_solver'

module Flabbergast
  class Solver

    def initialize(dictionary, grid)
      @dictionary = dictionary
      @grid       = grid
    end

    def solve!
      words = Set.new
      futures = %w( rows columns diagonals ).map do |direction|
        send "solve_#{direction}"
      end
      futures.each { |future| words += future.value }
      words.sort
    end

    private

    def solve_rows
      Celluloid::Future.new do
        # search each row and its substrings forward and back
        @grid.reduce([]) do |words, row|
          words += Flabbergast::StringSolver.new(row.join, @dictionary).solve.value
          words += Flabbergast::StringSolver.new(row.reverse.join, @dictionary).solve.value
          words
        end
      end
    end

    def solve_columns
      Celluloid::Future.new do
        # search each column and its substrings forward and back
        (0..@grid.size-1).to_a.reduce([]) do |words, n|
          row_string = @grid.map{|row| row[n]}
          words += Flabbergast::StringSolver.new(row_string, @dictionary).solve.value
          words += Flabbergast::StringSolver.new(row_string.reverse, @dictionary).solve.value
          words
        end
      end
    end

    def solve_diagonals
      Celluloid::Future.new do
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
        words += Flabbergast::StringSolver.new(diag1.join, @dictionary).solve.value
        words += Flabbergast::StringSolver.new(diag1.join.reverse, @dictionary).solve.value
        words += Flabbergast::StringSolver.new(diag2.join, @dictionary).solve.value
        words += Flabbergast::StringSolver.new(diag2.join.reverse, @dictionary).solve.value
        words
      end
    end
  end
end
