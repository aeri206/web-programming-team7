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

  get '/diy/' => 'company#index'
  get '/diy/result' => 'company#result'
  get '/company/' => 'company#list' #temporary

  get '/profile/:id', to: 'profile#index', as: 'profile'
  get '/profile/:id/edit', to: 'profile#edit', as: 'edit_profile'

  get 'articles/:article_id/like', to: 'articles#like', as: 'article_like'
  get 'articles/:article_id/unlike', to: 'articles#unlike', as: 'article_unlike'
  get 'articles/:company_id/like', to: 'company#like', as: 'company_like'


end
