class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit

  # before_action :configure_permitted_parameters, if: :devise_controller?
  #
  # protected
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :school_class_id, :subject_id, :email, :password, :password_confirmation])
  # end
end