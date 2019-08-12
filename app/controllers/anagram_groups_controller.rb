class AnagramGroupsController < ApplicationController
  def show
    render json: {
      groups: Word.anagram_groups
    }
  end
end
