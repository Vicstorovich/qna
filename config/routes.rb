Rails.application.routes.draw do
  root to: 'courses#index'
  resources :courses, except: %i[index]
end
