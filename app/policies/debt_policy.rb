class DebtPolicy < ApplicationPolicy

  def owned
      user == record.user
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