class TrendsController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
  before_filter :require_record, :only => :index
  
  def index
    @expenses = current_user.expenses
    @expenses_by_month = @expenses.group_by { |expense| expense.created_at.beginning_of_month }
    
    gon.expenses = @expenses.select("expense_type").where.not(expense_type: "").group(:expense_type).sum(:amount).to_a
    
    
  end
  
  def month
    
    @expenses = current_user.expenses.select("name, amount, id, created_at").where(["strftime('%Y', created_at) = ? AND strftime('%m', created_at) = ?", params[:year], params[:month] ])
    
    unless @expenses.empty?
      
      @recurring_total = @expenses.sum(:amount)
    
    
  else 
    redirect_to index_trends_path
  end
 
end

private

def require_record
  if Expense.where(:user_id => current_user.id).exists?
    
  else
    redirect_to index_expense_path
    flash[:notice] = "You must first add an expense before viewing Year Trend."
  end
end

  
end
