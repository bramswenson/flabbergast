module Flabbergast
  class GridLoader
    attr_reader :grid

    def initialize(file)
      @file = file
      @grid = []
      load_grid_file
    end

    def load_grid_file
      File.readlines(@file).each do |line|
        @grid << line.strip.split(//)
      end
      validate_grid
    end

    def validate_grid
      # TODO: better validation
      raise ArgumentError, 'malformed grid' unless @grid.size == @grid[0].size
    end
  end
end
