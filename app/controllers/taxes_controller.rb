class TaxesController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
  before_filter :require_record, :only => :show
  before_filter :require_no_record, :only => :new
  before_filter :authorize_canadian
  
  def new
    @tax = Tax.new
    gon.income = current_user.income
  end
  
  def edit
    @tax = Tax.find(params[:id])
    authorize @tax, :update?
  end
  
  def update
    @tax = Tax.find(params[:id])
    authorize @tax
    @tax.update(secure_params)
      redirect_to show_tax_path(current_user.tax)
  end
  
  def show
    @user = current_user
    @tax = Tax.find(params[:id])
    authorize @tax
  end
  
  def create
    @tax = Tax.new(secure_params)
    @tax.user = User.find(current_user.id)
    if @tax.save
    redirect_to show_tax_path(current_user.tax)
  else
    render :new
  end
  end
  
  private
  
  def authorize_canadian
    if [1228].include? current_user.country_id
      redirect_to authenticated_root_path
    else
    end
  end
  
  def user_not_authorized
    redirect_to show_tax_path(current_user.tax)
  end
  
  def require_no_record
    if Tax.where(:user_id => current_user.id).blank?
      
    else
      redirect_to show_tax_path(current_user.tax)
    end
  end
  
  def require_record
    if Tax.where(:user_id => current_user.id).exists?
      
    else
      redirect_to :new_tax
    end
  end
  
  def secure_params
    params.required(:tax).permit(:flexible_income, :flexible_taxes, :flexible_rrsp)
  end
  
end
