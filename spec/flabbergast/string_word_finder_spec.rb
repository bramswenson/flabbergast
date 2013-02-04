require 'spec_helper'
require 'flabbergast/dictionary'
require 'flabbergast/string_word_finder'

describe 'StringWordFinder' do
  let(:dictionary) do
    Flabbergast::Dictionary.new(
      File.expand_path('../../fixtures/dictionary.txt', __FILE__)
    )
  end
  let(:string) { 'NINER' }

  subject      { Flabbergast::StringWordFinder.new(string, dictionary) }
  let(:words)  { subject.find_words!.value }

  context 'given a string with words in it' do

    it 'finds all the words' do
      words.count.should be > 1
    end
  end

  context 'given a string with no words in it' do
    let(:string) { 'fty' }

    it 'finds no words' do
      words.count.should be == 0
    end
  end

  context 'given a string shorter than 2 chars' do
    let(:string) { 'f' }

    it 'finds no words' do
      words.count.should be == 0
    end
  end
end
