require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'class methods' do
    before(:each) do
      dear = DictionaryWord.create!(word: "dear")
      dare = DictionaryWord.create!(word: "dare")
      read = DictionaryWord.create!(word: "read")
      read = DictionaryWord.create!(word: "dread")
    end

    it 'bulk_create builds multiple words from an array' do
      expect(Word.count).to eq(0)

      words = ["dear", "dare", "read"]
      Word.bulk_create(words)

      expect(Word.count).to eq(3)
    end
  end

  describe 'instance methods' do
    it 'find_anagrams creates valid anagrams' do
      word = Word.create(name: "dear", char_count: 4)
      anagram = Word.create(name: "read", char_count: 4)

      expect(AnagramWord.all.count).to eq(0)
      word.find_anagrams
      expect(AnagramWord.all.count).to eq(2)
    end

    it 'valid_anagram returns true if a word is an anagram' do
      word = Word.create(name: "dear", char_count: 4)
      anagram = Word.create(name: "read", char_count: 4)

      expect(word.valid_anagram(anagram)).to eq(true)
      expect(word.valid_anagram(word)).to eq(false)

      anagram = Word.create(name: "dread", char_count: 5)
      expect(word.valid_anagram(anagram)).to eq(false)
    end
  end
end
