require 'spec_helper'
require 'flabbergast/dictionary'

describe 'Dictionary' do
  let(:file) { File.expand_path('../../fixtures/dictionary.txt', __FILE__) }
  subject { Flabbergast::Dictionary.new(file) }

  describe '#initialize' do
    it 'loads the words from disk' do
      subject.count.should be == 51
    end

    it 'stores the words in a prefix tree' do
      subject.words.should be_a Containers::Trie
    end
  end

  describe '#find_entry!' do

    context 'given a word that is in the dictionary' do

      it 'returns the dictionary entry' do
        subject.find_entry!('niner').should be == [ 'NINER', 'dem dudes wat bout to win dat super bowl!' ]
      end
    end

    context 'given a word that is not in the dictionary' do

      it 'returns nil' do
        subject.find_entry!('raven').should be_nil
      end
    end
  end
end
