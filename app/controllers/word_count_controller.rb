class WordCountController < ApplicationController
  def show
    render json: {
      statistics: Word.statistics
    }
  end
end
