Rails.application.routes.draw do
  root to: 'players#index'

  devise_for :players, :controllers => { :registrations => "registrations" }
  resources :matches, only: [:new, :create, :show]
  resources :players, only: [:show, :index] do
    resources :matches, only: [:index]
  end

  resources :challenges, only: [:create]
end
