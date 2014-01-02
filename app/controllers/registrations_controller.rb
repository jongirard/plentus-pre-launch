class RegistrationsController < Devise::RegistrationsController
  
  def new
    @plan = params[:plan]
  end
  
  protected
  
  def after_inactive_sign_up_path_for(resource)
      login_path
    end
end