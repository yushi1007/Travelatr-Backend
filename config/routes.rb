Rails.application.routes.draw do
  resources :likes
  resources :favorites
  resources :destinations
  
  post "/likes", to: "likes#create"
  
  get "users/:id", to: "users#show"
  get "/users", to: "users#index"
  post "/login", to: "users#login"
  post "/signup", to: "users#signup"
  get "/me", to: "users#me"
  patch "/me", to: "users#update"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
