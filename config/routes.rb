Rails.application.routes.draw do
  scope "(:lang)", lang: /en|ru/ do
    root to: 'appointment#index'

    resources :courses, only: %i[index] do
      resources :course_participants, only: %i[index], path: "participants"
      resources :lessons, only: %i[index show] do
        resources :homeworks, only: %i[create]
      end
    end

    namespace :dashboard do
      visualize
      resource :profiles, only: %i[edit update]
      resources :participated_courses, only: %i[index create destroy]

      resources :recorded_courses, type: 'RecordedCourse' do
        resources :lessons
      end

      resources :recorded_intenses, type: 'RecordedIntense' do
        resources :lessons
      end

      resources :online_intenses, type: 'OnlineIntense' do
        resources :lessons
      end

      resources :courses do
        resources :lessons do
         collection do
            post :edit_order
            put :update_order
          end
        end
        resources :homeworks, only: %i[index destroy]
        resources :course_users, except: %i[index show new edit create update destroy] do
          get 'not_pupil', on: :member
          get 'pupil', on: :member
        end
      end
    end

    get :signup, to: "registrations#new"
    get :login, to: "sessions#new"
    resource :registrations, only: %i[create]
    resource :sessions, only: %i[create destroy]
    resource :passwords, only: [:new, :create, :edit, :update]
  end
end
