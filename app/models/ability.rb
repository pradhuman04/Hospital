class Ability
  include CanCan::Ability

    def initialize(user)
      
    if user.patient?
      can :create, Appointment
      can [:update, :destroy], Appointment do |appointment|
        appointment.patient == user && appointment.pending?
      end
      can :show, Appointment do |appointment|
        appoinment.patient == user
      end
    elseif user.doctor?
      can :show, Appointment do |appointment|
        appointment.doctor == user
      end
      can [:update, :destroy], Appointment do |appointment|
        appointment.doctor == user && appointment.pending?
      end
    end
  end
end
