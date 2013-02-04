require 'algorithms'
require 'containers/trie'

module Flabbergast
  # Used to load all words from a file into
  # a prefix tree for searching.
  class Dictionary

    # @return [Containers::Trie] prefix tree of dictionary words
    attr_reader :words

    # @return [Integer] the number of valid words in the dictionary
    attr_reader :count

    # @param [String] dictionary_path the path to the dictionary file
    def initialize(dictionary_path)
      @count = 0
      @words = Containers::Trie.new
      load_dictionary_file(dictionary_path)
    end

    # Find an entry in the dictionary
    # @param [String] string the string to lookup in the dictionary
    # @return [Array[String, String]] an array with the word and definition
    def find_entry!(string)
      string = string.upcase
      [ string, words.get(string) ] if words.has_key?(string)
    end

    private

    def load_dictionary_file(dictionary_path)
      File.readlines(dictionary_path).each do |line|
        parts = line.split
        word = parts[0]
        definition = parts[1..-1].join(' ')
        next unless word
        @count += 1
        @words.push(word, definition)
      end
    end
  end
end
