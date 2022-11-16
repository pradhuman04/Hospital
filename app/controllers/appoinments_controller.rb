class AppoinmentsController < ApplicationController
  def index
    @appoinments = current_user.future_appoinments
  end
  
  def new 
    @action = 'new'
    @appoinment = Appoinment.new
    @note = @appoinment.notes.build({user_id: current_user.id})
    @all_doctor = User.get_all_doctors
  end



  def create
    @appoinment = Appoinment.new(appoinments_params)
    @appoinment.patient_id = current_user.id
    @all_doctors = User.get_all_doctors
  end

  private
    def appoinments_params
      params.require(:appoinment).permit(:date, :doctor_id, :patient_id, :time_slot_id)
    end
  end
