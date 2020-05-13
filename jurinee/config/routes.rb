Rails.application.routes.draw do
  devise_for :users

  get '/profile/:id', to: 'profile#index' 
  get '/profile/:id/edit', to: 'profile#edit' 
  post '/profile/:id', to: 'profile#update'
end
