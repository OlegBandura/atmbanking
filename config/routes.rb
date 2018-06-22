Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :users
  resources :accounts, only: %i[index show edit new create update]
  resources :users, only: %i[index show] do
    resources :withdraw, only: %i[index create]
    resources :transaction, only: %i[index create]
    resources :deposit, only: %i[index create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
