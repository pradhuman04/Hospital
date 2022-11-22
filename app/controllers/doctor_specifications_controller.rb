class DoctorSpecificationsController < ApplicationController
  skip_before_action :check_role, :only => [:new]

  def new
    @doctor_specification = DoctorSpecification.new
  end

  def create
    @doctor_specification = DoctorSpecification.new(doctor_specification_params)
    if @doctor_specificatio.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def doctor_specification_params
      params.require(:doctor_specification).permit(:specialization, :institute_name, :practicing_from, :clinic_address, :doctor_id)
        
    end
  end
