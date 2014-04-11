class AccountsController < ApplicationController
  layout "authorized_account"
  before_filter :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(secure_params)
    flash[:notice] = "Account Income Updated"
    redirect_to index_expense_path
    else
    render "edit"
    end
  end
  
  private
  
  def secure_params
    params.required(:user).permit(:flexible_income)
  end
  
end