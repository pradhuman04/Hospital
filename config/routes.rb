  Rails.application.routes.draw do
  
  #   resource :doctor_specifications
  # post 'doctor_specifications/new'
    

  root 'appointments#index'

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: "registrations"
    }

    devise_scope :user do
      authenticated :user do
        root 'appointments#index', as: 'authenticated'
      end
      unauthenticated :user do
        root 'sessions#new', as: 'unauthenticated'
      end
      match '/logout', :to => 'devise/session#destroy' , via: :all
    end
  end