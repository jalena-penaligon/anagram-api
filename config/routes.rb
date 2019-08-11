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
end
