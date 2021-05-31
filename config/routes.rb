Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders, only: [:index]
      get '/current_order', to: 'orders#current_order'
      post '/add_item', to: 'orders#add_item'
      post '/complete_order', to: 'orders#complete_order'

      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'

      resources :items, only: [:index]
      
    end
  end
end
