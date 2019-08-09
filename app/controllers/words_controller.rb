class WordsController < ApplicationController
  def index
    render json: Word.all
  end

  def create
    Word.bulk_create(params["words"])
    render status: 201,
    json: Word.all
  end
end
