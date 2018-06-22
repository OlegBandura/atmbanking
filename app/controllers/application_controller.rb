# class application controller
class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['LOGIN'].to_s, password:
  ENV['PASSWORD'].to_s
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
