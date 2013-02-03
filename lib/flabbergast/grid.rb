require 'flabbergast/grid_loader'
require 'flabbergast/grid_generator'

module Flabbergast
  # Used to represent a square grid of letters
  class Grid
    # @return [Array[Array]] an array of arrays of letters
    attr_reader :raw_grid

    # @param [Struct] options an object with file or size attributes
    def initialize(options)
      if options.file
        @raw_grid = load_grid_from_file(options.file)
      elsif options.size
        @raw_grid ||= generate_grid(options.size)
      end
      raise ArgumentError, 'size or file required' if @raw_grid.nil?
    end

    # @return [Integer] the size of the grid
    def size
      @raw_grid.size
    end

    private

    def load_grid_from_file(file)
      Flabbergast::GridLoader.new(file).grid
    end

    def generate_grid(size)
      Flabbergast::GridGenerator.new(size).grid
    end
  end
end
