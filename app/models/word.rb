class Word < ApplicationRecord

  def self.bulk_create(words)
    words.each do |word|
      if DictionaryWord.find_by(word: word) != nil
        Word.create(name: word)
      end
    end
  end

end
