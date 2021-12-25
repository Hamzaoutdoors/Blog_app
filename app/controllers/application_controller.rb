class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name posts_counter email password role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password current_password])
  end
end
