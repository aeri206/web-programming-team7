Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'user/:id/new_profile' => 'user/profiles#new', as: :profile
  post 'user/:id/new_profile' => 'user/profiles#create'

  get '/home', to: 'home#index'

  # get '/profile/:id', to: 'profile#index' 
  # get '/profile/:id/edit', to: 'profile#edit' 
  # post '/profile/:id', to: 'profile#update'
end
