Rails.application.routes.draw do
  scope :admin do
    root "admin#index"
  end
end
