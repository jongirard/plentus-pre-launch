class DebtsController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
  
  def new
    @debt = Debt.new
  end
  
  def create
    @debt = Debt.new(secure_params)
    @debt.user = User.find(current_user.id)
    if @debt.valid?
    @debt.store_raw_debt
    redirect_to :new_debt
  else
    render :new
  end
  end
  
  def index
   @debts = current_user.debts
  end
  
  def edit
    @debt = Debt.find(params[:id])
  end
  
  def update
    @debt = Debt.find(params[:id])
    @debt.update_attributes(secure_params)
      redirect_to :index_debt
  end
  
  private
  
  def secure_params
    params.required(:debt).permit(:interest_annual, :duration, :present_balance, :future_value, :budget_monthly)
  end
end