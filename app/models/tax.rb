class Tax < ActiveRecord::Base
  belongs_to :user
  
def store_raw_taxes
    tax = Tax.new(user_id: user.id, income: income, taxes: taxes, rrsp: rrsp)
    tax.save
end
before_save :default_values

  def default_values
    self.income ||= '0'
    self.taxes ||= '0'
    self.rrsp ||= '0'
  end

def flexible_income
  income
end

def flexible_income=(income)
  self.income = income.gsub(',', '') unless income.blank?
end

def flexible_taxes
  taxes
end

def flexible_taxes=(taxes)
  self.taxes = taxes.gsub(',', '') unless taxes.blank?
end

def flexible_rrsp
  rrsp
end

def flexible_rrsp=(rrsp)
  self.rrsp = rrsp.gsub(',', '') unless rrsp.blank?
end

def taxable_income 
  calculation = self.income - self.rrsp
  return calculation
end

def federal
  case taxable_income
    when proc {|n| n <= 11038}
      return 0
    when 11039..43561
      return self.taxable_income * 0.15 - self.taxes
    when 43562..87123
      return ((self.taxable_income - 43561) * 0.22) + 6534 - self.taxes
    when 87124..135054
      return ((self.taxable_income - 87123) * 0.26) + 16118 - self.taxes
    when proc {|n| n > 135054}
      return ((self.taxable_income - 135054) * 0.29) + 28580 - self.taxes
  end
end

def provincial
case user.state_id
when 53 #BC
    case taxable_income
      when proc {|n| n <= 10276}
        return 0
      when 10277..37568
        return self.taxable_income * 0.0506 - self.taxes
      when 37569..75138
        return ((self.taxable_income - 37568) * 0.077) + 1901 - self.taxes
      when 75139..86268
        return ((self.taxable_income - 75138) * 0.105) + 4794 - self.taxes
      when 86269..104754
        return ((self.taxable_income - 86268) * 0.1229) + 5963 - self.taxes
      when proc {|n| n > 104754}
        return ((self.taxable_income - 104754) * 0.147) + 8235 - self.taxes
    end
    
when 52 #AB
    case taxable_income
      when proc {|n| n <= 17593}
        return 0
      when proc {|n| n > 17593}
        return self.taxable_income * 0.10 - self.taxes
    end
    
when 60 #ON
    case taxable_income
      when proc {|n| n <= 9574} 
        return 0
      when 9575..39723
        return self.taxable_income * 0.0505 - self.taxes
      when 39724..79448
        return ((self.taxable_income - 39723) * 0.0915) + 2006 - self.taxes
      when 79449..509000
        return ((self.taxable_income - 79448) * 0.1116) + 5641 - self.taxes
      when proc {|n| n > 509000}
        return ((self.taxable_income - 509000) * 0.1316) + 53579 - self.taxes
    end
end    
end
end