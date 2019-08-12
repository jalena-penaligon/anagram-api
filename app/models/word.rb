class Word < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def self.bulk_create(words)
    new_words = words.map do |word|
      if DictionaryWord.find_by(word: word) != nil
        key = word.downcase.split("").sort.join
        new_word = Word.new(name: word, key: key, char_count: word.length)
      end
    end
    create_words(new_words)
  end

  def self.create_words(words)
    new_words = words.select { |word| word != nil}
    if new_words != [nil]
      Word.import new_words
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

  def self.most_anagrams
    anagram = find_most_common_key
    Word.where(key: anagram.first.key).pluck(:name).sort
  end

  def self.find_most_common_key
    select("words.key, count(words.key) as total_anagrams")
    .group(:key)
    .order('total_anagrams DESC')
    .limit(1)
  end

  def self.anagram_matcher(words_array)
    words = Word.where(name: words_array)
    if words_array.count == words.count
      words.all? { |word| word.key == words.first.key }
    else
      false
    end
  end

  def self.anagram_groups
    @groups = Hash.new
    get_keys.each do |key|
      words = Word.where(key: key).pluck(:name).sort
      add_group(words)
    end
    @groups.sort.to_h
  end

  def self.add_group(words)
    if @groups[words.length.to_s] != nil && words.length > 1
      @groups[words.length.to_s] << words
    elsif words.length > 1
      @groups[words.length.to_s] = [words]
    end
  end

  def self.get_keys
    Word.pluck(:key).uniq
  end
end
