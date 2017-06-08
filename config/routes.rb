Rails.application.routes.draw do
  root to: "products#index"

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :products, only: [:index] do
    post "archive", on: :member
  end

  get  "login"  => "user_sessions#new",     as: :login
  post "logout" => "user_sessions#destroy", as: :logout
end
