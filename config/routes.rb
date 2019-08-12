Rails.application.routes.draw do
  scope :words do
    get '/', to: 'words#index'
    post '/', to: 'words#create'
    delete '/:word', to: 'words#destroy'
    delete '/', to: 'words#destroy_all'
  end

  scope :anagrams do
    get '/:word', to: 'anagrams#show'
  end

  scope :word_count do
    get '/', to: 'word_count#show'
  end

  scope :most_anagrams do
    get '/', to: 'most_anagrams#show'
  end

  scope :anagram_matcher do
    get '/', to: 'anagram_matcher#show'
  end
end
