class Debt < ActiveRecord::Base
  include Formulas::Debt
  belongs_to :user
  
  before_save :default_values

    def default_values
      self.interest_annual ||= '1.5'
      self.duration ||= '1'
      self.present_balance ||= '0'
      self.future_value ||= '0'
      self.budget_monthly ||= '10'
    end
    
  def flexible_interest_annual
    interest_annual
  end

  def flexible_interest_annual=(interest_annual)
    self.interest_annual = interest_annual.gsub('%', '') unless interest_annual.blank?
  end
  
  ['present_balance','future_value','budget_monthly'].each do |attr|
      define_method("flexible_#{attr}") do
        self.send(attr)
      end

      define_method("flexible_#{attr}=") do |arg|
        self.send("#{attr}=", arg.tr('$ ,', '')) unless arg.blank?
      end 
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
    calculation = nper(self.monthly_interest / 100, self.budget_monthly, self.present_balance, 0)
  end

end
