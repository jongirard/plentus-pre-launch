class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  unless config.consider_all_requests_local
  #rescue_from Exception, :with => :error_generic
  #rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from ActionController::InvalidAuthenticityToken, :with => :render_already_signed_out
  end
  
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end
  
  private
  
  def after_sign_in_path_for(resource)
    finances_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
    login_path
  end
  
  def after_inactive_sign_up_path_for(resource)
    login_path
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :fullname
  end
  
  def render_already_signed_out
    redirect_to login_path, notice: "You've been signed out elsewhere. Please sign in again."
  end
  
  def render_not_found
    redirect_to root_path
  end
 
  def error_generic
    render :template => 'errors/404.html.erb', :layout => false, :status => 404
  end
  
end
