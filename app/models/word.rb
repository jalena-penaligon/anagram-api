class Word < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def self.bulk_create(words)
    words.each do |word|
      if DictionaryWord.find_by(word: word) != nil
        key = word.split("").sort.join
        new_word = Word.create(name: word, key: key, char_count: word.length)
      end
    end
  end

  def self.anagrams(word, limit = nil, nouns = "true")
    if nouns == "true"
      Word.all_anagrams(word, limit)
    else
      Word.filtered_anagrams(word, limit)
    end
  end

  def self.all_anagrams(word, limit = nil)
    where(key: word.key)
    .where.not(id: word.id)
    .limit(limit)
    .pluck(:name).sort
  end

  def self.filtered_anagrams(word, limit)
    all_words = Word.all_anagrams(word, limit)
    all_words.select do |word|
      word != word.capitalize
    end
  end

  def self.statistics
    {total_words: Word.all.count,
    min_length: Word.minimum(:char_count),
    max_length: Word.maximum(:char_count),
    average_length: Word.average(:char_count).round(2)}
  end
end
