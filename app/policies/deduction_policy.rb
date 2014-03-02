class DeductionPolicy < ApplicationPolicy
  attr_reader :user, :deduction
  
  def initialize(user, deduction)
    @user = user
    @deduction = deduction
  end
  
  def owned
      deduction.user_id == user.id
  end
  
  def show?
    owned
  end
  
  def update?
    owned
  end

end