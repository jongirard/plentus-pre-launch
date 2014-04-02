class Expense < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :amount
  
  def flexible_amount
    amount
  end
  
  def flexible_amount=(amount)
    self.amount = amount.tr('$ ,', '') unless amount.blank?
  end

def self.total_value
  Expense.sum(:amount)
end

def total_value
  Expense.sum(:amount)
end

end
