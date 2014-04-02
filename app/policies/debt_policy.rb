class DebtPolicy < ApplicationPolicy
  attr_reader :user, :debt
  
  def initialize(user, debt)
    @user = user
    @debt = debt
  end
  
  def owned
      debt.user_id == user.id
  end
  
  def index?
    true
  end
  
  def show?
    owned
  end
  
  def update?
    owned
  end
  
  def destroy?
    owned
  end
end