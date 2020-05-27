Rails.application.routes.draw do
  devise_for :users
  # devise_for :profile

  root 'home#index'
  get '/home', to: 'home#index'
  
  
  resources :articles, only: [:new, :create]

  get '/wiki/:chapter' => 'articles#show', :defaults => {:type => 'wiki'}
  get '/wiki/:chapter/:sub_chapter' => 'articles#show', :defaults => {:type => 'wiki'}
  get '/wiki' => 'articles#index', :defaults => {:type => 'wiki'}
  get '/expert/:chapter' => 'articles#show', :defaults => {:type => 'expert'}
  get '/expert/:chapter/:sub_chapter' => 'articles#show', :defaults => {:type => 'expert'}
  get '/expert' => 'articles#index', :defaults => {:type => 'expert'}
  
  
  
  # get 'user/:id/new_profile' => 'user/profiles#new', as: :profile
  # post 'user/:id/new_profile' => 'user/profiles#create', as: :profile

  get '/profile/:id', to: 'profile#index', as: 'profile'
  get '/profile/:id/edit', to: 'profile#edit', as: 'edit_profile'
  # post '/profile/:id', to: 'profile#update'
end
