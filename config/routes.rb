Rails.application.routes.draw do
  resources :matches, only: [:new, :create]
end
