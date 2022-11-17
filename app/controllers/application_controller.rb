class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :check_role
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def check_role
    if self.role == 'doctor' && self.doctor_specifications.empty?
  end


  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :first_name, :last_name, :gender, :date_of_birth, :role)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :first_name, :last_name, :gender, :date_of_birth, :role)}
  end
end
