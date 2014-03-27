class ExpensesController < ApplicationController 
  layout "authorized_application"
  before_filter :require_income, :only => :index
  
  def new
    @expense = Expense.new
  end
  
  def create
    @expense = Expense.new(secure_params)
    @expense.user = User.find(current_user.id)
    @expense.save
    respond_to do |format|
      format.html { redirect_to index_expense_path }
      format.js
    end
  end
  
  def index
    @expenses = current_user.expenses
  end
  
  def destroy
  end
  
  private
  
  def secure_params
    params.required(:expense).permit(:name, :amount, :expense_type)
  end
  
  private
  
  def require_income
   if current_user.income.blank?
      redirect_to user_personal_path
      flash[:notice] = "Please enter your annual income before continuing"
   end
  end
  
end