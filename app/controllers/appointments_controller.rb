class AppointmentsController < ApplicationController
  before_action :is_patient?, only: [:new, :create]
  before_action :find_current_appointment, except: [:index]

    def index
      @appointments = current_user.future_appointments
    end
    
    def new 
      @action = 'new'
      @appoinment = Appoinment.new
      @note = @appointment.notes.build({user_id: current_user.id})
      @all_doctor = User.get_all_doctors
    end
  
    def get_slots
      @all_slots = Time_slot.pluck(:slot)
      booked_slot = Appoinment.where(doctor_id: params["doctor"],date:params["date"].pluck(:time_slot_id))
    
      @if_edit = params["ifEdit"]
      @slot = params["slot"]
      if @if_edit and @action == "new"
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
  
    def edit
      authorize! :edit, @appointment
      @all_doctors = User.get_all_doctors
      @slot = params["slot"]
      @action = 'edit'
    end
  
    def update
      authorize! :update, @appointment
      @appointment.status = Appointment.get_current_status(@appointment.date)
      @appointment.slot_id = TimeSlot.find_by_slot(params[:slot]).id if params[:slot] != nil
      @all_doctors = User.get_all_doctors
      if @appointment.update(appointments_params)
        redirect_to root_path, notice: 'Updated successfully!'
      else
        render 'edit', notice: 'Unable to save Appointment, Try again!'
      end
    end
  
    def destroy
      redirect_to root_path, notice: 'Appointment Deleted!' if @appointment.destroy
    end
  
    def show
      @booked_time = TimeSlot.find_by('id = ?', @appointment.time_slot_id).slot if @appointment.time_slot_id.present?
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
  
    def archive
      @archives = current_user.past_appointments
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
