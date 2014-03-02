class TaxPolicy < ApplicationPolicy
  attr_reader :user, :tax
  
  def initialize(user, tax)
    @user = user
    @tax = tax
  end
  
  def owned
      tax.user_id == user.id
  end
  
  def show?
    owned
  end
  
  def update?
    owned
  end

end