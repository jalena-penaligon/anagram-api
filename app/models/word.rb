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
    potential_anagrams = Word.where(char_count: self.name.length)
    potential_anagrams.each do |anagram|
      if valid_anagram(anagram, self)
        add_anagrams(anagram, self)
      end
    end
  end

  def valid_anagram(anagram, word)
    anagram.id != word.id && arrange(anagram.name) == arrange(word.name)
  end

  def arrange(word)
    word.split("").sort
  end

  def add_anagrams(anagram, word)
    create_anagram_word(anagram, self) && create_anagram_word(self, anagram)
  end

  def create_anagram_word(word, anagram)
    AnagramWord.find_or_create_by(anagram_id: anagram.id,
                                  word_id: word.id,
                                  anagram_name: anagram.name)
  end
end
