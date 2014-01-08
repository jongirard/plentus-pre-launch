class RegistrationsController < Devise::RegistrationsController
  
  before_filter :set_plan, :only => :new
  before_filter :check_region, :only => :create
  
  def new
    @plan = params[:plan]
    if @plan && ENV['PLANS'].include?(@plan) && @plan != "admin"
      super
    else
      redirect_to page_path('plans')
    end
  end

  
  protected
  
  def set_plan
    @plan = params[:plan]
    if @plan == 'plus'
      flash.now[:notice] = "Please note: this plan is only available in select regions currently."
    end
  end
  
  def check_region
    @plan = params[:plan]
    if @plan == 'plus' && params[:user][:country_id] != '1039' && params[:user][:state_id] != ['52', '53', '60']
      redirect_to page_path('plans')
      flash[:notice] = "Unfortunately the plus plan isn't available at this time in the region you selected."
    else
      
    end
  end
  
  def after_inactive_sign_up_path_for(resource)
      login_path
    end
end