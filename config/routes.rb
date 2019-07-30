Rails.application.routes.draw do
  get "detail/index"
  get "place/hotel"
  get "place/travel"
  get "place/food"
  get "search/index"
  root "static_pages#home"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i(create destroy)
  resources :reactions, only: %i(show create destroy)
  resources :comments, only: %i(show edit create destroy)
  resources :posts, only: %i(create destroy)

  namespace :admin do
    root "/admin#index"
    resources :cities
    resources :travelplaces
  end
end
