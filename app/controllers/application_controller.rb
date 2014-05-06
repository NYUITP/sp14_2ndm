require 'rest-client'
require 'json'

class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def access_denied(exception)
    redirect_to root, :alert => exception.message
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :firstname, :lastname) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :firstname, :lastname) }
  end
  protect_from_forgery with: :null_session
end