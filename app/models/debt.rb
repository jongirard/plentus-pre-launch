class Debt < ActiveRecord::Base
  include Formulas::Debt
  belongs_to :user
  
  def store_raw_debt
      debt = Debt.new(user_id: user.id, interest_annual: interest_annual, duration: duration, present_balance: present_balance, future_value: future_value, budget_monthly: budget_monthly)
      debt.save
  end
  
  before_save :default_values

    def default_values
      self.future_value ||= '0'
    end
  
  
  def monthly_interest
    calculation = self.interest_annual / 12
    return calculation
  end
  
  def payment
    calculation = pmt(self.monthly_interest / 100, self.duration, self.present_balance, self.future_value)
    return calculation
  end
  
  def budgeted_duration
    calculation = nper(self.monthly_interest / 100, self.budget_monthly, self.present_balance, self.future_value)
  end

end
