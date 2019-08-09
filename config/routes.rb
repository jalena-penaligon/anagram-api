Rails.application.routes.draw do
  resources :words, only: [:index, :create]

  get '/anagrams/:word', to: 'anagrams#show'
end
