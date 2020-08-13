Rails.application.routes.draw do
  resources :comments
  resources :reviews
  resources :restaurants
  resources :users
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
end
