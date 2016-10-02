# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render text: exception, status: 500
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def render_500(exception = nil)
    logger.error "Rendering 500 with exception: #{exception.class}" if exception
    render file: "#{Rails.root}/public/500.html", layout: false, status: 500
  end
end
