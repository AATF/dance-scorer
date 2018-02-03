Rails.application.routes.draw do
  resources :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :sessions, :only => [:create, :new, :destroy]
  resources :groups
  resources :users
  resources :dancers
  resources :scores

  match "login"  => "sessions#new", :as => "login", via: :all
  match "logout" => "sessions#destroy", :as => "logout", via: :all
end
