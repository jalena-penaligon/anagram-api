class ChangeColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :dictionary_words, :key, :string

    add_column :words, :key, :string
  end
end
