class MostAnagramsController < ApplicationController
  def show
    render json: {
      most_anagrams: Word.most_anagrams
    }
  end
end
