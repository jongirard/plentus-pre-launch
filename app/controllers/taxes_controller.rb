class TaxesController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
  before_filter :require_no_record, :only => :new
  
  def require_no_record
    if Tax.where(:user_id => current_user.id).blank?
      
    else
      redirect_to :index_tax
    end
  end
  
  def new
    @tax = Tax.new
  end
  
  def edit
    @tax = Tax.find(params[:id])
  end
  
  def update
    @tax = Tax.find(params[:id])
    @tax.update_attributes(secure_params)
      redirect_to :index_tax
  end
  
  def index
   @taxes = current_user.taxes
  end
  
  def create
    @tax = Tax.new(secure_params)
    @tax.user = User.find(current_user.id)
    if @tax.valid?
    @tax.store_raw_taxes
    redirect_to finances_path
  end
  end
  
  private
  
  def secure_params
    params.required(:tax).permit(:flexible_income, :taxes, :rrsp)
  end
  
end
