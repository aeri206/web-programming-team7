Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  get '/home', to: 'home#index'
  
  
  resources :articles, only: [:new, :create]

  get '/wiki/:chapter' => 'articles#show', :defaults => {:type => 'wiki'}
  get '/wiki/:chapter/:sub_chapter' => 'articles#show', :defaults => {:type => 'wiki'}
  get '/wiki' => 'articles#index', :defaults => {:type => 'wiki'}
  get '/expert/:chapter' => 'articles#show', :defaults => {:type => 'expert'}
  get '/expert/:chapter/:sub_chapter' => 'articles#show', :defaults => {:type => 'expert'}
  get '/expert' => 'articles#index', :defaults => {:type => 'expert'}
  get '/search' => 'articles#search'

  get '/profile/:id', to: 'profile#index', as: 'profile'
  get '/profile/:id/edit', to: 'profile#edit', as: 'edit_profile'
  # post '/profile/:id', to: 'profile#update'
end
