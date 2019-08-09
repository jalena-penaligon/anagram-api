class WordsController < ApplicationController
  def index
    render json: Word.all
  end

  def create
    Word.bulk_create(params["words"])
    render status: 201,
    json: Word.all
  end

  def destroy
    word = Word.find_by(name: params["word"])
    anagram_words = AnagramWord.where(word_id: word.id)
                               .or(AnagramWord.where(anagram_id: word.id))
    word.destroy
    anagram_words.destroy_all
  end

  def destroy_all
    Word.destroy_all
  end
end
