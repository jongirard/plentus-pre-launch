class RegistrationsController < Devise::RegistrationsController
  
  def new
    @plan = params[:plan]
    if @plan && ENV['PLANS'].include?(@plan) && @plan != "admin"
      super
    else
      redirect_to page_path('plans')
    end
  end
  
  protected
  
  def after_inactive_sign_up_path_for(resource)
      login_path
    end
end