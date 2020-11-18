Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, :lists, :users

      post "/usersignupform", to: "users#create"
      post "/userloginform", to: "users#login"

      post '/login', to: 'auth#create'
      delete '/logout', to: 'auth#destroy'
      get '/get_current_user', to: 'auth#get_current_user'
    end
  end
end
