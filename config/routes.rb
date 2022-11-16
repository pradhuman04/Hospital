  Rails.application.routes.draw do
  root 'appoinments#index'

    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
    
  end 

