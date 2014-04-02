class ExpensePolicy < ApplicationPolicy
  attr_reader :user, :expense
  
  def initialize(user, expense)
    @user = user
    @expense = expense
  end
  
  def owned
      expense.user_id == user.id
  end
  
  def index?
    true
  end
  
  def destroy?
    owned
  end
end