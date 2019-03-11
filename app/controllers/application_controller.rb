class ApplicationController < ActionController::Base
	add_flash_types :success, :warning, :danger, :info
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :selecionatenant

  protected

  def configure_devise_permitted_parameters
    registration_params = [:subdomain, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) do 
        |u| u.permit(registration_params << :current_password)
      end
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) do 
        |u| u.permit(registration_params) 
      end
    end
  end

  def selecionatenant
    if user = current_user
      Apartment::Tenant.switch!(user.subdomain)
    else
      Apartment::Tenant.switch!()
    end
  end
end
