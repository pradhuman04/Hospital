class AppointmentsController < ApplicationController
  before_action :find_current_appointment, except: [:index, :new, :create, :get_slots]

  def index
    if current_user.role == 'patient'
      @appointments = current_user.patient_appointments
    else
      @appointments = current_user.doctor_appointments
    end
  end
    
    def new 
      @appointment = Appointment.new
      @time_slots = TimeSlot.all
      @doctors = User.get_all_doctors
    end
  
    def get_slots
      @all_slots = Time_slot.pluck(:slot)
      booked_slot = Appointment.where(doctor_id: params["doctor"],date:params["date"].pluck(:time_slot_id))
    end
    
    def create
      @appointment = Appointment.new(appointments_params)
      @appointment.patient_id = current_user.id
      if check_available_appointment(appointments_params)
        if @appointment.save
          redirect_to appointment_path(@appointment), notice: 'Appointment saved!'
        else
          redirect_to new_appointment_path #, notice: 'Unable to create Appointment, try again!'
        end
      else
        redirect_to new_appointment_path 'new' #, notice: 'Appointment already taken'
      end
    end
  
    def edit
      @all_doctors = User.get_all_doctors
      @slot = params["slot"]
    end
  
    def update
      @appointment = Appointment.find(params[:id])
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
        params.require(:appointment).permit(:date, :doctor_id, :patient_id, :time_slot_id, :status)
      end

      def find_current_appointment
        @appointment = Appointment.find(params[:id])
      end

      def check_available_appointment(appointments_params)
        doctor = User.find_by(id: appointments_params["doctor_id"])
        appointment = doctor.patient_appointments.find_by(date: appointments_params["date"], time_slot_id: appointments_params["time_slot_id"])
        appointment ? false : true
      end
    end
