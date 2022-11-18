class AppoinmentsController < ApplicationController
  def index
   @appoinment = Appoinment.all
  end
  
  def new 
    @action = 'new'
    @appoinment = Appoinment.new
  
    @all_doctor = User.get_all_doctors
  end

  def get_slots
    @all_slots = Time_slot.pluck(:slot)
    booked_slot = Appoinment.where(doctor_id: params["doctor"],date:params["date"].pluck(:time_slot_id))
  
    @slot = params["slot"]                                                                                      
    if @action == "new"
      @test_slots = all_slots
    else
      @test_slots = all_slots - TimeSlot.where(id: booked_slots).pluck(:slot)
    end
    end
  
  def create
    @appoinment = Appoinment.new(appoinments_params)
    @appoinment.patient_id = current_user.id
    @all_doctors = User.get_all_doctors
    if params['slot'].present?
      @appoinment.time_slot_id = TimeSlot.find_by_slot(params[:slot]).id
    else
      render "new", notice: 'please select time slot' and return if params["slot"].blank?
    end
    if @appoinment.save
      redirect_to root_path, notice: 'Appoinment saved!'
    else render 'new', notice: 'Unable to create Appoinment, try again!'
    end
  end

  private
    def appoinments_params
      params.require(:appoinment).permit(:date, :doctor_id, :patient_id, :time_slot_id)
    end
  end
