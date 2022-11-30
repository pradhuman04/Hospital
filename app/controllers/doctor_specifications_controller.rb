class DoctorSpecificationsController < ApplicationController
  skip_before_action :check_role, only: %i[new create]

  def new
    @doctor_specification = DoctorSpecification.new
  end

  def create
    @doctor_specification = current_user.doctor_specifications.new(doctor_specification_params)
    if @doctor_specification.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def doctor_specification_params
    params.require(:doctor_specification).permit(:specialization, :institute_name, :practicing_from, :clinic_address,
                                                 :doctor_id)
  end
end
