namespace :import do
  task dictionary: :environment do
    words = File.open('db/dictionary.txt').map do |line|
      DictionaryWord.new(word: line)
    end

    DictionaryWord.import words
  end
end
