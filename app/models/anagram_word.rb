class AnagramWord < ApplicationRecord
  validates_presence_of :word_id, :anagram_id
end
