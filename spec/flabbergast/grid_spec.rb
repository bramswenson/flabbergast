require 'spec_helper'
require 'ostruct'

describe 'Grid' do
  subject { Flabbergast::Grid.new(options) }

  describe '#initialize' do

    context 'given a size option' do
      let(:size)    { 8 }
      let(:options) { OpenStruct.new(size: size) }

      it 'creates a grid with the specified size' do
        subject.raw_grid.size.should be == size
      end

      it 'sets the size attribute' do
        subject.size.should be == size
      end
    end

    context 'given a file option' do
      let(:file)    {
        File.expand_path('../../fixtures/test_grid.txt', __FILE__)
      }
      let(:options) { OpenStruct.new(file: file) }

      it 'loads the grid from the file' do
        subject.raw_grid.size.should be == 4
      end

      it 'sets the size attribute' do
        subject.size.should be == 4
      end

      it 'uses the grid from the file' do
        subject.raw_grid.should be == [
          %w( C A B S ),
          %w( B A T S ),
          %w( F A T S ),
          %w( G A P S ),
        ]
      end
    end

    context 'given a no size or file option' do
      let(:options) { OpenStruct.new }
      it 'throws an error' do
        expect{ Flabbergast::Grid.new(options) }.to raise_error('size or file required')
      end
    end
  end
end
