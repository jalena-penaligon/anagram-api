require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'class methods' do
    before(:each) do
      dear = DictionaryWord.create!(word: "dear", key: "ader")
      dare = DictionaryWord.create!(word: "dare", key: "ader")
      read = DictionaryWord.create!(word: "read", key: "ader")
      dread = DictionaryWord.create!(word: "dread", key: "adder")
    end

    it 'bulk_create builds multiple words from an array' do
      expect(Word.count).to eq(0)

      words = ["dear", "dare", "read"]
      Word.bulk_create(words)

      expect(Word.count).to eq(3)
    end

    it 'anagrams finds all anagrams from corpus' do
      dear = Word.create(name: "dear", key: "ader", char_count: 4)
      dare = Word.create(name: "dare", key: "ader", char_count: 4)
      read = Word.create(name: "read", key: "ader", char_count: 4)

      expect(Word.anagrams(dear)).to eq(["dare", "read"])
    end

    it 'statistics returns a hash of stat info' do
      dear = Word.create!(name: "dear", key: "ader", char_count: 4)
      abstract = Word.create!(name: "abstract", key: "aabcrstt", char_count: 8)
      drive = Word.create!(name: "drive", key: "deirv", char_count: 5)

      expect(Word.statistics[:total_words]).to eq(3)
      expect(Word.statistics[:min_length]).to eq(4)
      expect(Word.statistics[:max_length]).to eq(8)
      expect(Word.statistics[:average_length]).to eq(5.67)
    end
  end
end
