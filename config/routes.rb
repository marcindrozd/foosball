Rails.application.routes.draw do
  devise_for :players
  resources :matches, only: [:new, :create]
end
