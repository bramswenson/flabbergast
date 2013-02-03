require 'algorithms'
require 'containers/trie'

module Flabbergast
  class Dictionary
    attr_reader :words, :count

    def initialize(dictionary_path)
      @count = 0
      @words = Containers::Trie.new
      load_dictionary_file(dictionary_path)
    end

    private

    def load_dictionary_file(dictionary_path)
      File.readlines(dictionary_path).each do |line|
        word, definition = line.split
        next unless word
        @count += 1
        @words.push(word, definition)
      end
    end
  end
end
