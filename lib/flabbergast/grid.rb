require 'flabbergast/grid_loader'
require 'flabbergast/grid_generator'
require 'flabbergast/dictionary'
require 'terminal-table'

module Flabbergast
  class Grid
    attr_reader :words, :size

    def initialize(options)
      @options = options
      @grid = load_grid_from_file(options.file) if options.file
      @grid ||= generate_grid(@options.size)
      @size = @grid.size
    end

    def solve!
      @words = solver.solve!
    end

    def to_s
      Terminal::Table.new(title: title, rows: @grid).to_s unless @grid.empty?
    end

    private

    def title
      "#{@grid.size}x#{@grid.size} Wordgrid"
    end

    def solver
      @solver ||= Flabbergast::Solver.new(dictionary, @grid)
    end

    def dictionary
      @dictionary ||= Flabbergast::Dictionary.new(@options.dictionary_file)
    end

    def load_grid_from_file(file)
      Flabbergast::GridLoader.new(file).grid
    end

    def generate_grid(size)
      Flabbergast::GridGenerator.new(size).grid
    end
  end
end
