Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  resources :users, only: [:show, :index]
end
