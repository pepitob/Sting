Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :challenges, only: [:new, :create,:index, :show] do
    resources :cards, only: [] do
      member do
        get :apply_card
      end
    end
    resources :messages, only: %I[index show create]
    resources :participations, only: [:new, :create] do
      member do
        get :select_participant
      end
    end
  end
  resources :users, only: [:show]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end
end
