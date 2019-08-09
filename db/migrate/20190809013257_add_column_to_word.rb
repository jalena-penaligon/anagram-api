class AddColumnToWord < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :char_count, :integer
  end
end
