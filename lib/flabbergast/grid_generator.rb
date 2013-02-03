module Flabbergast
  class GridGenerator
    ALPHABET = ('A'..'Z').to_a.freeze

    def initialize(size)
      @size = size
    end

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
