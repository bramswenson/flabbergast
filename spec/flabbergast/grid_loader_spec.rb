require 'spec_helper'

describe 'GridLoader' do
  let(:good_file) { File.expand_path('../../fixtures/test_grid.txt', __FILE__) }
  let(:bad_file)  { File.expand_path('../../fixtures/test_bad_grid.txt', __FILE__) }

  it 'loads the grid from disk' do
    Flabbergast::GridLoader.new(good_file).grid.should_not be_empty
  end

  it 'validates the grid' do
    expect{
      Flabbergast::GridLoader.new(bad_file)
    }.to raise_error('malformed grid')
  end
end
