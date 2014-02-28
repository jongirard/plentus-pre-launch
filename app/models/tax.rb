class Tax < ActiveRecord::Base
  belongs_to :user

before_save :default_values

  def default_values
    self.income ||= '0'
    self.taxes ||= '0'
    self.rrsp ||= '0'
  end
  
['income','taxes','rrsp'].each do |attr|
    define_method("flexible_#{attr}") do
      self.send(attr)
    end

    define_method("flexible_#{attr}=") do |arg|
      self.send("#{attr}=", arg.tr('$ ,', '')) unless arg.blank?
    end 
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
when 52 #AB
    case taxable_income
      when proc {|n| n <= 17593}
        return 0
      when proc {|n| n > 17593}
        return self.taxable_income * 0.10 - self.taxes
    end
    
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
    
when 54 #MB
    case taxable_income
      when proc {|n| n <= 8884}
        return 0   
      when 8885..31000
        return self.taxable_income * 0.108 - self.taxes
      when 31001..67000
        return ((self.taxable_income - 31000) * 0.1275) + 3348 - self.taxes
      when proc {|n| n > 67000}
        return ((self.taxable_income - 67000) * 0.174) + 7938 - self.taxes
    end
    
when 55 #NB
    case taxable_income
      when proc {|n| n <= 9388}
        return 0
      when 9389..38954
        return self.taxable_income * 0.0939 - self.taxes
      when 38955..77908
        return ((self.taxable_income - 38954) * 0.1346) + 3658 - self.taxes
      when 77909..126662
        return ((self.taxable_income - 77908) * 0.1446) + 8901 - self.taxes
      when proc {|n| n > 126662}
        return ((self.taxable_income - 126662) * 0.1607) + 15951 - self.taxes
    end
    
when 56 #NF
    case taxable_income
      when proc {|n| n <= 8451}
        return 0
      when 8452..33748
        return self.taxable_income * 0.077 - self.taxes
      when 33749..67496
        return ((self.taxable_income - 33748) * 0.125) + 2599 - self.taxes
      when proc {|n| n > 67496}
        return ((self.taxable_income - 67496) * 0.133) + 6817 - self.taxes
    end
    
when 57 #NWT
    case taxable_income
      when proc {|n| n <= 13546}
        return 0
      when 13547..39453
        return self.taxable_income * 0.059 - self.taxes
      when 39454..78908
        return ((self.taxable_income - 39453) * 0.086) + 2328 - self.taxes
      when 78909..128286
        return ((self.taxable_income - 78908) * 0.122) + 5721 - self.taxes
      when proc {|n| n > 128286}
        return ((self.taxable_income - 128286) * 0.1405) + 11745 - self.taxes
    end
    
when 58 #NS
    case taxable_income
      when proc {|n| n <= 8841}
        return 0
      when 8842..29590
        return self.taxable_income * 0.0879 - self.taxes
      when 29591..59180
        return ((self.taxable_income - 29590) * 0.1495) + 2601 - self.taxes
      when 59181..93000
        return ((self.taxable_income - 59180) * 0.1667) + 7025 - self.taxes
      when 93001..150000
        return ((self.taxable_income - 93000) * 0.175) + 12662 - self.taxes
      when proc {|n| n > 150000}
        return ((self.taxable_income - 150000) * 0.21) + 22637 - self.taxes
    end
    
when 59 #NV
    case taxable_income
      when proc {|n| n <= 12455}
        return 0
      when 12456..41535
        return self.taxable_income * 0.04 - self.taxes
      when 41536..83071
        return ((self.taxable_income - 41535) * 0.07) + 1661 - self.taxes
      when 83072..135054
        return ((self.taxable_income - 83071) * 0.09) + 4569 - self.taxes
      when proc {|n| n > 135054}
        return ((self.taxable_income - 135054) * 0.115) + 9247 - self.taxes
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
    
when 61 #PEI
    case taxable_income
      when proc {|n| n <= 7708}
        return 0
      when 7709..31984
        return self.taxable_income * 0.098 - self.taxes
      when 31985..63969
        return ((self.taxable_income - 31984) * 0.138) + 3134 - self.taxes
      when proc {|n| n > 63969}
        return ((self.taxable_income - 63969) * 0.167) + 7548 - self.taxes
    end
    
when 62 #QC
    case taxable_income
      when proc {|n| n <= 11195}
        return 0
      when 11196..41095
        return self.taxable_income * 0.16 - self.taxes
      when 41096..82190
        return ((self.taxable_income - 41095) * 0.2) + 6575 - self.taxes
      when 82191..100000
        return ((self.taxable_income - 82190) * 0.24) + 14794 - self.taxes
      when proc {|n| n > 100000}
        return ((self.taxable_income - 100000) * 0.0175) + 14794 - self.taxes
    end
    
when 63 #SK
    case taxable_income
      when proc {|n| n <= 15241}
        return 0
      when 15242..42206
        return self.taxable_income * 0.11 - self.taxes
      when 42207..122589
        return ((self.taxable_income - 42206) * 0.13) + 4720 - self.taxes
      when proc {|n| n > 122589}
        return ((self.taxable_income - 122589) * 0.15) + 15078 - self.taxes
    end
    
when 64 #YK
    case taxable_income
      when proc {|n| n <= 11038}
        return 0
      when 11039..43561
        return self.taxable_income * 0.0704 - self.taxes
      when 43562..87123
        return ((self.taxable_income - 43561) * 0.0968) + 3067 - self.taxes
      when 87124..135054
        return ((self.taxable_income - 87123) * 0.1144) + 7283 - self.taxes
      when proc {|n| n > 135054}
        return ((self.taxable_income - 135054) * 0.1276) + 12767 - self.taxes
    end

end    
end
end