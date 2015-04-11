Rails.application.routes.draw do
  root to: 'players#index'

  devise_for :players
  resources :matches, only: [:new, :create, :show]
  resources :players, only: [:show, :index]
end
