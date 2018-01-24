Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static#index'

  resources :groups, only: [:index]
  resources :users, only: [:index]
  resources :dancers, only: [:index]

end
