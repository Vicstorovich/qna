Rails.application.routes.draw do
  root to: 'appointment#index'

  resources :courses

  get :signup, to: "registrations#new"
  get :login, to: "sessions#new"

  resource :registrations, only: %i[create]

  resource :sessions, only: %i[create destroy]
end
