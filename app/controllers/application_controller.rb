class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_role
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def check_role
    return unless current_user && current_user.role == 'doctor' && current_user.doctor_specifications.empty?

    redirect_to new_doctor_specification_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :first_name, :last_name, :gender, :date_of_birth, :role, :type)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :first_name, :last_name, :gender, :date_of_birth, :role,
               :type)
    end
  end
end
