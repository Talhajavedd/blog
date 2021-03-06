class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
  	if resource.roles.pluck(:name).include? "admin"
  		admins_path
  	else
  		puts "not found"
  		root_path
  	end
  end

protected
  def configure_permitted_parameters
	added_attrs = [:username, :remember_me, :email, :password, :password_confirmation, attachment_attributes: [:id, :avatar], roles_attributes: [:id, :name]]
    
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
