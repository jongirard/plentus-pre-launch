class Expense < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :amount
  
def self.total_value
  Expense.sum(:amount)
end

def total_value
  Expense.sum(:amount)
end

end
