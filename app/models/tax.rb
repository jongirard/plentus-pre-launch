class Tax < ActiveRecord::Base
  belongs_to :user
  
def store_raw_taxes
    tax = Tax.new(user_id: user.id, income: income, taxes: taxes, rrsp: rrsp)
    tax.save
end

def flexible_income
  income
end

def flexible_income=(income)
  self.income = income.gsub(',', '') unless income.blank?
end

def taxable_income 
  calculation = self.income - self.taxes - self.rrsp
  return calculation
end

def federal
  if calculation = self.income <= 11038
    return 0
  elsif calculation = self.income > 11039 && self.income <= 43561
    return self.income * 0.15
  elsif calculation = self.income > 43561 && self.income <= 87123
    return ((self.income - 43561) * 0.22) + 6534
  elsif calculation = self.income > 87123 && self.income <= 135054
    return ((self.income - 87123) * 0.26) + 16118
  elsif calculation = self.income > 135054
    return ((self.income - 135054) * 0.29) + 28580
  end
end

def provincial
  if user.state_id == 53 #BC
    if calculation = self.income <= 10276
      return 0
    elsif calculation = self.income > 10276 && self.income <= 37568
      return self.income * 0.0506
    elsif calculation = self.income > 37568 && self.income <= 75138
      return ((self.income - 37568) * 0.077) + 1901
    elsif calculation = self.income > 75139 && self.income <= 86268
      return ((self.income - 75138) * 0.105) + 4794
    elsif calculation = self.income > 86268 && self.income <= 104754
      return ((self.income - 86268) * 0.1229) + 5963
    elsif calculation = self.income > 104754
      return ((self.income - 104754) * 0.147) + 8235
    end
  end
  if user.state_id == 52 #AB
    if calculation = self.income <= 17593
      return 0
    elsif calculation = self.income < 17593
      return self.income * 0.10
    end
  end
  if user.state_id == 60 #ON
    if calculation = self.income <= 9574
      return 0
    elsif calculation = self.income > 9574 && self.income <= 39723
      return self.income * 0.0505
    elsif calculation = self.income > 39723 && self.income <= 79448
      return ((self.income - 39723) * 0.0915) + 2006
    elsif calculation = self.income > 79448 && self.income <= 509000
      return ((self.income - 79448) * 0.1116) + 5641
    elsif calculation = self.income > 509000
      return ((self.income - 509000) * 0.1316) + 53579
    end
  end
end
end