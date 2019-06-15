Rails.application.routes.draw do
  root to: 'appointment#index'

  resources :courses

  resource :registrations, only: %i[new create]

  resource :sessions, only: %i[new create destroy]
end
