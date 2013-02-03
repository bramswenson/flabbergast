module Flabbergast
  # Used to generate square grids of letters from the alphabet
  class GridGenerator
    ALPHABET = ('A'..'Z').to_a.freeze

    # @param [Integer] size the size of the grid to be generated
    def initialize(size)
      @size = size
    end

    # the generated grid
    # @return [Array[Array]] an array of arrays of letters
    def grid
      grid = []
      @size.times do
        row = []
        @size.times { row << ALPHABET.sample }
        grid << row
      end
      grid
    end
  end
end
