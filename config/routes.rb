Rails.application.routes.draw do
  namespace :api do
    resources :auth_tokens, only: :create
    namespace :v1 do
      resources :courses, only: :index
    end
  end

  scope :admin do
    devise_for :admins, controllers: { sessions: 'admin/admins/sessions' }
  end

  namespace :admin do
    root to: 'users#index'
    resources :users, only: [:index, :edit, :update]
  end

  root to: 'appointment#index'
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }

  resources :courses, only: %i[index] do
    resources :course_participants, only: %i[index], path: "participants"
    resources :lessons, only: %i[index show] do
      resources :homeworks, only: %i[create]
    end
  end

  namespace :dashboard do
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
        resources :shares, only: [:create], controller: :lesson_shares
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
