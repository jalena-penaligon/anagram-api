words = File.open('db/dictionary.txt').map do |line|
  key = line.strip.split("").sort.join
  DictionaryWord.new(word: line.strip, key: key)
end

DictionaryWord.import words
