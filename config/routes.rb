Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :challenges, only: [:new, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :challenges, only: [:show]
  # Defines the root path route ("/")
  # root "articles#index"
  resources :challenges, only: [:index] do
    resources :participations, only: [:new, :create]
  end
end
