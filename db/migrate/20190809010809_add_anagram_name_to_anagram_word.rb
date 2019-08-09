class AddAnagramNameToAnagramWord < ActiveRecord::Migration[5.2]
  def change
    add_column :anagram_words, :anagram_name, :string
  end
end
