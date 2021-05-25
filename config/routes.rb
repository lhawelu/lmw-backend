Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders, only: [:index]
      resources :users, only: [:create]
      resources :items, only: [:index]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end
end
