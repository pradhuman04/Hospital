  Rails.application.routes.draw do
  
    #  resource :doctor_specifications
  
    

  root 'appointments#index'

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      
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
    resources :appointments do
      get :get_slots, on: :collection
      resource :notes
    end
    match 'appointments/:id/cancel_appointment' => "appointments#cancel_appointments", as: 'cancel_appointment', via: :post
    
    match 'appointments/:id/visited_patient_appointment' => "appointments#visited_patient_appointment", as: 'visited_patient_appointment', via: :post
  end