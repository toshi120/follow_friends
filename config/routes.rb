Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show, :index]
end
