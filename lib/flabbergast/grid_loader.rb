module Flabbergast
  # Used to load grids from disk. The grids should be rows of letters.
  #
  # e.g. a 3x3 grid
  #
  # CAT
  # DOT
  # THE
  #
  class GridLoader
    # @return [Array[Array]] an array of arrays of letters
    attr_reader :grid

    # @param [String] file pathname of grid file
    def initialize(file)
      @file = file
      @grid = []
      load_grid_file
    end

    private

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
