  Rails.application.routes.draw do
  get 'doctor_specifications/index'

  root 'appoinments#index'

    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
  end