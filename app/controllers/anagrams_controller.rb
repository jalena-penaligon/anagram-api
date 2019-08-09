class AnagramsController < ApplicationController
  def show
    word = Word.find_by(name: params["word"])
    render json: {
      anagrams: AnagramWord.where(word_id: word.id).pluck(:anagram_name).sort
    }
  end
end
