class Word < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def self.bulk_create(words)
    words.each do |word|
      if DictionaryWord.find_by(word: word) != nil
        new_word = Word.create(name: word, char_count: word.length)
        new_word.find_anagrams
      end
    end
  end

  def find_anagrams
    x_letter_words = Word.where(char_count: self.name.length)
    x_letter_words.each do |word|
      if word.id != self.id && arrange(word.name) == arrange(self.name)
        AnagramWord.find_or_create_by(anagram_id: word.id,  word_id: self.id, anagram_name: word.name)
        AnagramWord.find_or_create_by(anagram_id: self.id,  word_id: word.id, anagram_name: self.name)
      end
    end
  end

  def arrange(word)
    word.split("").sort
  end

end
