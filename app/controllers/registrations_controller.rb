class RegistrationsController < Devise::RegistrationsController

  before_filter :check_region, :only => :create
  
  def new
    @plan = params[:plan]
    if @plan && ENV['PLANS'].include?(@plan) && @plan != "admin"
      super
    else
      redirect_to page_path('plans')
    end
  end
  
  def update
      
     account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
     
     account_update_params.delete(:password) if account_update_params[:password].blank?
     account_update_params.delete(:password_confirmation) if account_update_params[:password].blank? && account_update_params[:password_confirmation].blank?

      @user = User.find(current_user.id)
      if @user.update_attributes(account_update_params)
        set_flash_message :notice, :updated
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to after_update_path_for(@user)
      else
        render "edit"
      end
    end
    
    def billing
    end
  
  protected
  
  def check_region
    @plan = params[:plan]
    if @plan == 'plus' && params[:user][:country_id] == '1228'
      redirect_to register_path(:plan => 'core')
      flash[:notice] = "Only the CORE plan is available in the region you selected, at this time."
    else
      
    end
  end
  
  def after_inactive_sign_up_path_for(resource)
      new_user_session_path
    end
end