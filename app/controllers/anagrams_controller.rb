class AnagramsController < ApplicationController
  def show
    render json: {
      anagrams: get_anagrams
    }
  end

  private

  def get_anagrams
    word = Word.find_by(name: params["word"])
    if word == nil
      return []
    else
      AnagramWord.where(word_id: word.id)
                 .limit(params["limit"])
                 .pluck(:anagram_name).sort
     end
  end
end
