Rails.application.routes.draw do
  root to: 'appointment#index'

  resources :courses, only: %i[index] do
    resources :course_participants, only: %i[index], path: "participants"
    resources :lessons, only: %i[index show] do
      resources :homeworks, only: %i[create]
    end
  end

  namespace :dashboard do
    resource :profiles, only: %i[edit update]
    resources :participated_courses, only: %i[index create destroy]
    resources :courses do
      resources :lessons do
        collection do
          post :edit_order
          put :update_order
        end
      end
      resources :homeworks, only: %i[index destroy]
    end
  end

  get :signup, to: "registrations#new"
  get :login, to: "sessions#new"

  resource :registrations, only: %i[create]

  resource :sessions, only: %i[create destroy]
end
