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
      read = DictionaryWord.create!(word: "dread", key: "adder")
    end

    it 'bulk_create builds multiple words from an array' do
      expect(Word.count).to eq(0)

      words = ["dear", "dare", "read"]
      Word.bulk_create(words)

      expect(Word.count).to eq(3)
    end

    it 'anagrams finds all anagrams from corpus' do
      dear = Word.create(name: "dear", key: "ader")
      dare = Word.create(name: "dare", key: "ader")
      read = Word.create(name: "read", key: "ader")

      expect(Word.anagrams(dear)).to eq(["dare", "read"])
    end
  end
end
