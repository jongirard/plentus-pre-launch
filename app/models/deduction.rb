class Deduction < ActiveRecord::Base
  belongs_to :user
  before_save :default_values

    def default_values
      self.home_sqf ||= '10'
      self.business_sqf ||= '0'
      self.monthly_expenses ||= '0'
      self.business_kilometers ||= '0'
      self.start_kilometers ||= '2'
      self.vehicle_expenses ||= '0'
      self.short_flight ||= '0'
      self.short_meal ||= '0'
      self.short_entertainment ||= '0'
      self.short_lodging ||= '0'
      self.long_flight ||= '0'
      self.long_meal ||= '0'
      self.long_entertainment ||= '0'
      self.long_lodging ||= '0'
    end
  
  ['home_sqf','business_sqf','monthly_expenses','business_kilometers','start_kilometers','vehicle_expenses','short_flight','short_meal','short_entertainment','short_lodging','long_flight','long_meal','long_entertainment','long_lodging'].each do |attr|
      define_method("flexible_#{attr}") do
        self.send(attr)
      end

      define_method("flexible_#{attr}=") do |arg|
        self.send("#{attr}=", arg.tr('$ ,', '')) unless arg.blank?
      end 
  end
  
  def home_deductible
    calculation = (self.business_sqf / self.home_sqf) * self.monthly_expenses
    return calculation
  end
  
  def vehicle_deductible
    calculation = (self.business_kilometers / self.start_kilometers) * self.vehicle_expenses
    return calculation
  end
  
  def short_travel_deductible
    calculation = self.short_flight + self.short_meal + self.short_entertainment + self.short_lodging
    return calculation
  end
  
  def long_travel_deductible
    calculation = self.long_flight + self.long_meal + self.long_entertainment + self.long_lodging
    return calculation
  end
  
  def total_travel_deductible
    calculation = short_travel_deductible + long_travel_deductible
    return calculation
  end
  
  def total_deductible
    calculation = self.home_deductible + self.vehicle_deductible + self.short_travel_deductible + self.long_travel_deductible
    return calculation
  end
  
end
