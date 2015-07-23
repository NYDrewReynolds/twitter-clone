Rails.application.routes.draw do
  resources :tweets, only: [:update, :create]
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/twitter', as: :login
  delete '/logout', as: :logout, to: 'sessions#destroy'

  get '/feed', to: 'feed#show'
  root 'home#show'

end
