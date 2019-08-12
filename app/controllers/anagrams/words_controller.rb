class Anagrams::WordsController < ApplicationController
  def destroy
    word = Word.find_by(name: params["word"])
    words = Word.where(key: word.key)
    words.destroy_all
  end
end
