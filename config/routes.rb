Rails.application.routes.draw do
  get "static_pages/home"
  scope :admin do
    root "admin#index"
  end
end
