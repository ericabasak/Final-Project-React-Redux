Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, :lists, :users

      post "/usersignupform", to: "users#create"
      post "/userloginform", to: "users#login"

      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      # get '/logged_in', to: 'sessions#is_logged_in?'
      get '/get_current_user', to: 'sessions#get_current_user'
    end
  end
  
end
