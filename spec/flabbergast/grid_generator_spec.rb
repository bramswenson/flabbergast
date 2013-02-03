require 'spec_helper'
require 'flabbergast/grid_generator'

describe 'GridGenerator' do
  let(:size) { 4 }
  subject    { Flabbergast::GridGenerator.new(size) }

  it 'picks letters from the standard alphabet' do
    Flabbergast::GridGenerator::ALPHABET.should be == ('A'..'Z').to_a
  end

  it 'generates a random grid of the specified size' do
    subject.grid.size.should be == size
  end

end
