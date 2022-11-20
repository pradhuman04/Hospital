  Rails.application.routes.draw do
  

  resource :doctor_specifications

  root 'appoinments#index'

    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
  end