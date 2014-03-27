class TrendsController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
  
  def index
    @expenses = current_user.expenses
    @expenses_by_month = @expenses.group_by { |expense| expense.created_at.beginning_of_month }
    @total = @expenses.sum(:amount)
    
    gon.expenses = @expenses.select("expense_type").where.not(expense_type: "").group(:expense_type).count.to_a
  end
  
  def month
    
    @expenses = current_user.expenses.select("name, amount, id, created_at").where(["strftime('%Y', created_at) = ? AND strftime('%m', created_at) = ?", params[:year], params[:month] ])
    
    unless @expenses.empty?

    @expenses_by_month = @expenses.group_by { |expense| expense.created_at.beginning_of_month }
    
  else 
    redirect_to index_trends_path
  end
 
end

  
end
