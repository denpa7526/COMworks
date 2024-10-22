class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_admin_user
    @current_admin_user ||= current_user&.admin_user
  end
  helper_method :current_admin_user

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :username, :position, :phone_number, :encrypted_password, :role])
  end

end
