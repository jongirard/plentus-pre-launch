class ExpensePolicy < ApplicationPolicy
  
  def owned
      user == record.user
  end
  
  def index?
    true
  end
  
  def destroy?
    owned
  end
end