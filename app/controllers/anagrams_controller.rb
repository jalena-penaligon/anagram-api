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
      Word.anagrams(word, params["limit"], params["nouns"])
    end
  end
end
