Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :doctor_specifications

  root 'appointments#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    authenticated :user do
      root 'appointments#index', as: 'authenticated'
    end
    unauthenticated :user do
      root 'sessions#new', as: 'unauthenticated'
    end
    match '/logout', to: 'devise/session#destroy', via: :all
  end

  resources :appointments do
    resource :note
  end
end
