class CreateAnagramWords < ActiveRecord::Migration[5.2]
  def change
    create_table :anagram_words do |t|
      t.integer :word_id
      t.integer :anagram_id
    end
  end
end
