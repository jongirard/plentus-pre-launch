class DebtsController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
  before_filter :require_record, :only => :index
  
  def new
    @debt = Debt.new
  end
  
  def create
    @debt = Debt.new(secure_params)
    @debt.user = User.find(current_user.id)
    if @debt.save
      redirect_to show_debt_path(@debt)
  else
    render :new
  end
  end
  
  def index
   @debts = current_user.debts
  end
  
  def edit
    @debt = Debt.find(params[:id])
    authorize @debt, :update?
  end
  
  def show
    @debt = Debt.find(params[:id])
    authorize @debt
  end
  
  def update
    @debt = Debt.find(params[:id])
    authorize @debt
    @debt.update(secure_params)
      redirect_to :index_debt
  end
  
  def destroy
    @debt = Debt.find(params[:id])
    authorize @debt
    @debt.destroy
    redirect_to index_debt_path
  end
  
  private
  
  def require_record
    if Debt.where(:user_id => current_user.id).exists?
      
    else
      redirect_to :new_debt
    end
  end
  
  def secure_params
    params.required(:debt).permit(:name, :flexible_interest_annual, :duration, :flexible_present_balance, :flexible_future_value, :flexible_budget_monthly)
  end
end