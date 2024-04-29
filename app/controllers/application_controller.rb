class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :landing?
  before_action :set_time_zone, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :email, :password, :password_confirmation, :current_password, :timezone, :profile_picture])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :email, :password, :password_confirmation, :timezone, :profile_picture])
  end

  private

  def landing?
    request.path == root_path
  end

  def after_sign_in_path_for(resource)
    user_path(username: resource.username)
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def set_time_zone
    Time.zone = current_user.timezone if current_user.try(:timezone)
  end
end
