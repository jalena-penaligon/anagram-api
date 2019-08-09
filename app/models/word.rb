class Word < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def self.bulk_create(words)
    words.each do |word|
      if DictionaryWord.find_by(word: word) != nil
        key = word.split("").sort.join
        new_word = Word.create(name: word, key: key)
      end
    end
  end

  def self.anagrams(word, limit = nil)
    where(key: word.key)
    .where.not(id: word.id)
    .limit(limit)
    .pluck(:name).sort
  end
end
