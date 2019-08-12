class AnagramMatcherController < ApplicationController
  def show
    render json: {
      are_anagrams?: Word.anagram_matcher(params["words"])
    }
  end
end
