Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations, :omniauth_callbacks => "users/omniauth_callbacks" }
  post "/rate" => "rater#create", :as => "rate"
  get "search/index"
  root "static_pages#home"
  scope :admin do
    root "admin#index"
  end
  resources :users do
    member do
      get :following, :followers, :newfeed
    end
  end
  resources :relationships, only: %i(create destroy)
  resources :reactions, only: %i(show create destroy)
  resources :comments, only: %i(show edit create destroy)
  resources :posts, only: %i(create destroy)
  resources :travel_places, only: :index
  resources :cities, only: :index
end
