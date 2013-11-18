class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Exception, :with => :error_generic
  
  def error_generic
    render :template => 'errors/404.html.erb', :layout => false, :status => 404
  end
end
