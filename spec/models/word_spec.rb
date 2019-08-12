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
      drae = DictionaryWord.create!(word: "Drae", key: "ader")
      dread = DictionaryWord.create!(word: "dread", key: "adder")
    end

    it 'bulk_create builds multiple words from an array' do
      expect(Word.count).to eq(0)

      words = ["dear", "dare", "read"]
      Word.bulk_create(words)

      expect(Word.count).to eq(3)
    end

    it 'bulk_create adds words with keys that are the same whether noun or not' do
      expect(Word.count).to eq(0)

      words = ["dear", "Drae"]
      Word.bulk_create(words)
    
      expect(Word.first.key).to eq("ader")
      expect(Word.last.key).to eq("ader")
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
    describe 'anagram methods' do
      before(:each) do
        @dear = Word.create(name: "dear", key: "ader", char_count: 4)
        @dare = Word.create(name: "dare", key: "ader", char_count: 4)
        @read = Word.create(name: "read", key: "ader", char_count: 4)
        @drae = Word.create(name: "Drae", key: "ader", char_count: 4)
        @arid = Word.create(name: "arid", key: "adir", char_count: 4)
        @raid = Word.create(name: "raid", key: "adir", char_count: 4)
        @urn = Word.create(name: "urn", key: "nru", char_count: 4)
        @run = Word.create(name: "run", key: "nru", char_count: 4)
      end

      it 'anagrams finds all anagrams from corpus' do
        expect(Word.anagrams(@dear)).to eq(["Drae", "dare", "read"])
      end

      it 'filtered_anagrams returns only words that are not proper nouns' do
        expect(Word.anagrams(@dear, nil, "false")).to eq(["dare", "read"])
      end

      it 'most_anagrams returns an array of words that have the most anagrams' do
        expect(Word.most_anagrams).to eq(["Drae", "dare", "dear", "read"])
      end

      it 'anagram_matcher returns true if words are anagrams' do
        words = ["dear", "read", "dare"]
        expect(Word.anagram_matcher(words)).to eq(true)

        words = ["dread", "read"]
        expect(Word.anagram_matcher(words)).to eq(false)
      end

      it 'anagram_groups sort anagrams by the number of words in a collection' do
        expect(Word.anagram_groups).to have_key("2")
        expect(Word.anagram_groups["2"].count).to eq(2)
        expect(Word.anagram_groups).to have_key("4")
      end
    end
  end
end
