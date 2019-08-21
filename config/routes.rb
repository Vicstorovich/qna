Rails.application.routes.draw do
  root to: 'appointment#index'
    devise_for :users, controllers: { registrations: 'users/registrations' }

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
end
