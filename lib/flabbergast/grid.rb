require 'flabbergast/grid_loader'
require 'flabbergast/grid_generator'
require 'flabbergast/dictionary'

module Flabbergast
  class Grid
    attr_reader :raw_grid

    def initialize(options)
      if options.file
        @raw_grid = load_grid_from_file(options.file)
      elsif options.size
        @raw_grid ||= generate_grid(options.size)
      end
      raise ArgumentError, 'size or file required' if @raw_grid.nil?
    end

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
