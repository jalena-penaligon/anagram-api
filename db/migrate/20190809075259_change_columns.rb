class ChangeColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :dictionary_words, :key, :string

    rename_column :words, :char_count, :key
    change_column :words, :key, :string
  end
end
