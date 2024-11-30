Rails.application.routes.draw do
  root "hey#random"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :create ]
      resources :sessions, only: [ :create ]
    end
  end
end
