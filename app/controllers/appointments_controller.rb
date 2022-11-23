class AppointmentsController < ApplicationController
  
  before_action :find_current_appointment, except: [:index]
  load_and_authorize_resource

    def index
      @appointments = current_user.future_appointments
    end
    
    def new 
      @action = 'new'
      @appointment = Appointment.new
      @note = @appointment.notes.build({user_id: current_user.id})
      @all_doctor = User.get_all_doctors
    end
  
    def get_slots
      @all_slots = Time_slot.pluck(:slot)
      booked_slot = Appointment.where(doctor_id: params["doctor"],date:params["date"].pluck(:time_slot_id))
    
    end
    
    def create
      @appointment = Appointment.new(appoinments_params)
      @appointment.patient_id = current_user.id
      @all_doctors = User.get_all_doctors
      if params['slot'].present?
        @appointment.time_slot_id = TimeSlot.find_by_slot(params[:slot]).id
      else
        render "new", notice: 'please select time slot' and return if params["slot"].blank?
      end
      if @appointment.save
        redirect_to root_path, notice: 'Appointment saved!'
      else render 'new', notice: 'Unable to create Appointment, try again!'
      end
    end
  
    def edit
      
      @all_doctors = User.get_all_doctors
      @slot = params["slot"]
     
    end
  
    def update
      
      @appointment = Appointment.find(appoinments_params[:id])
      if @appointment.update(appoinments_params)
         redirect_to root_path, notice: 'Updated successfully!'
      else
        render 'edit', notice: 'Unable to save Appointment, Try again!'
      end
    end
  
    def destroy
      redirect_to root_path, notice: 'Appointment Deleted!' if @appointment.destroy
    end
  
    def show
      @booked_time = TimeSlot.find_by('id = ?', @appointment.time_slot_id).slot 
    end
  
    def cancel_appointment
      @appointment.status = Appointment.statuses[:cancelled]
      if @appointment.save
        redirect_to appointments_path, notice: 'Appointment Cancelled!'
      else
        redirect_to root_path, notice: 'Unable to cancel, try again!'
      end
    end
  
    def visited_patient_appointment
      @appointment.status = Appointment.statuses[:visited]
      if @appointment.save
        redirect_to appointments_path, notice: 'Appointment Visited!'
      else
        redirect_to root_path, notice: 'Unable to change status, try again!'
      end
    end
  
  
    private
      def appointments_params
        params.require(:appointment).permit(:date, :doctor_id, :patient_id, :image, :time_slot_id,
          notes_attributes: [:id, :description, :user_id, :_destroy])
      end
  
      def find_current_appointment
        @appointment = Appointment.find(params[:id])
      end
    end
