Rails.application.routes.draw do
  resources :admin
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

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
