words = File.open('db/dictionary.txt').map do |line|
  DictionaryWord.new(word: line.strip)
end

DictionaryWord.import words
