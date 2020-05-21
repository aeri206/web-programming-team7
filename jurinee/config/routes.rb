Rails.application.routes.draw do
  devise_for :users
  # devise_for :profile

  root 'home#index'
  get '/home', to: 'home#index'

  # get 'user/:id/new_profile' => 'user/profiles#new', as: :profile
  # post 'user/:id/new_profile' => 'user/profiles#create', as: :profile

  get '/profile/:id', to: 'profile#index', as: 'profile'
  get '/profile/:id/edit', to: 'profile#edit', as: 'edit_profile'
  # post '/profile/:id', to: 'profile#update'
end
