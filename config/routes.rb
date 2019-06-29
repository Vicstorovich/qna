Rails.application.routes.draw do
  root to: 'appointment#index'

  resources :courses, only: %i[index] do
    resources :lessons, only: %i[index show]
  end

  namespace :dashboard do
    resources :courses do
      resources :lessons
    end
  end

  get :signup, to: "registrations#new"
  get :login, to: "sessions#new"

  resource :registrations, only: %i[create]

  resource :sessions, only: %i[create destroy]
end
