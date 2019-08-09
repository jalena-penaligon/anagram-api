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
    word.destroy
  end

  def destroy_all
    Word.destroy_all
  end
end
