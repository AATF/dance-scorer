Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }

  root "home#index"

  resources :admin, only: :index
  resources :sessions
  resources :groups
  resources :users
  resources :dancers
  resources :scores

  namespace :admin do
    resources :settings
    resources :scores
  end

  match "login"  => "sessions#new", :as => "login", via: :all
  match "logout" => "sessions#destroy", :as => "logout", via: :all

  # Dynamic error routes
  match "/400", to: "errors#show", code: 400, via: :all
  match "/401", to: "errors#show", code: 401, via: :all
  match "/403", to: "errors#show", code: 403, via: :all
  match "/404", to: "errors#show", code: 404, via: :all
  match "/422", to: "errors#show", code: 422, via: :all
  match "/500", to: "errors#show", code: 500, via: :all
  match "/502", to: "errors#show", code: 502, via: :all
  match "/503", to: "errors#show", code: 503, via: :all
  match "/504", to: "errors#show", code: 504, via: :all
  match "/errors/:code", to: "errors#show", via: :all
end
