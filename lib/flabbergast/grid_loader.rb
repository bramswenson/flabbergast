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
      @grid.each do |row|
        raise ArgumentError, 'malformed grid' if row.size != @grid.size
      end
    end
  end
end
