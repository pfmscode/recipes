class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def please_sign_in
    unless user_signed_in?
      flash[:red] = "Please log in to an account first!"
      redirect_to root_url
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :first_name
      devise_parameter_sanitizer.for(:account_update) << :first_name
    end

    def record_not_found
      flash[:red] = 'We can\'t find that. 😰'
      redirect_to root_url
    end
end
