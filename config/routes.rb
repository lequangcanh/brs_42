Rails.application.routes.draw do
  root "home_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/password", to: "password_changes#new"
  post "/password", to: "password_changes#create"
  resources :users
  resources :books, only: [:index, :show]
  resources :requests, only: [:index, :create, :destroy]
  resources :marks, only: [:new, :create, :update]
  namespace :admin do
    resources :categories
    resources :users, only: [:index, :destroy, :update]
    resources :books
    resources :requests, only: [:index, :update]
  end
  resources :relationships, only: [:create, :destroy, :index]
  resources :reviews
  resources :likes, only: [:create, :destroy]
  resources :reviews do
    resources :comments
  end
end
