class DeductionPolicy < ApplicationPolicy

  def owned
    user == record.user
  end
  
  def show?
    owned
  end
  
  def update?
    owned
  end

end