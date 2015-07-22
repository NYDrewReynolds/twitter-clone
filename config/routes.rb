Rails.application.routes.draw do
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/twitter', as: :login
  delete '/logout', as: :logout, to: 'sessions#destroy'

  get '/feed', to: 'feed#show'
  root 'home#show'

  resources :tweets, only: [:create]
end
