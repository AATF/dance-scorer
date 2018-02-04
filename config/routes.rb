Rails.application.routes.draw do
  root "home#index"

  resources :admin, only: :index
  resources :sessions
  resources :groups
  resources :users
  resources :dancers
  resources :scores

  namespace :admin do
    resources :settings
  end

  match "login"  => "sessions#new", :as => "login", via: :all
  match "logout" => "sessions#destroy", :as => "logout", via: :all
end
