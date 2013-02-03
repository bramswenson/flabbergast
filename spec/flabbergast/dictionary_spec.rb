require 'spec_helper'
require 'flabbergast/dictionary'

describe 'Dictionary' do
  let(:file) { File.expand_path('../../fixtures/dictionary.txt', __FILE__) }
  subject { Flabbergast::Dictionary.new(file) }

  it 'loads the words from disk' do
    subject.count.should be == 50
  end

  it 'stores the words in a prefix tree' do
    subject.words.should be_a Containers::Trie
  end
end
